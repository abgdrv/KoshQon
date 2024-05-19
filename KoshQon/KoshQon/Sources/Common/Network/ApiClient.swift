//
//  ApiClient.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.05.2024.
//

import Foundation
import Alamofire
import Combine
import SVProgressHUD

final class ApiClient {
    private lazy var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        if #available(iOS 13.0, *) {
            configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0)
        }
        
        return Session(configuration: configuration)
    }()
    
    static let shared = ApiClient()
    
    private init() {}
    
    var authToken: String? {
        set {
            UserDefaultsService.shared.set(value: newValue, for: Constants.authToken)
        }
        get {
            UserDefaultsService.shared.value(for: Constants.authToken) as? String
        }
    }
    
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, showLoad: Bool = true) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            if showLoad {
                SVProgressHUD.show()
                SVProgressHUD.setDefaultMaskType(.clear)
            }
            
            self.session.request(urlConvertible)
                .validate()
                .responseJSON { [weak self] response in
                    guard let self = self else { return }
                    
                    if showLoad {
                        SVProgressHUD.dismiss()
                        SVProgressHUD.setDefaultMaskType(.clear)
                    }
                    
                    let headers = response.response?.allHeaderFields ?? [:]
                    if let authToken = headers["Authorization"] as? String {
                        self.authToken = authToken
                    }
                    
                    switch response.result {
                    case .success:
                        self.log(urlConvertible, response)
                        
                        guard let data = response.data else {
                            promise(.failure(response.error ?? AFError.responseValidationFailed(reason: .dataFileNil)))
                            return
                        }
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            promise(.success(object))
                        } catch {
                            promise(.failure(error))
                        }
                        
                    case .failure(let error):
                        self.log(urlConvertible, response)
                        
                        if response.response?.statusCode == 401 {
                            Constants.isExpired = true
                        } else {
                            Constants.isExpired = false
                        }
                        
                        guard let data = response.data else {
                            promise(.failure(error))
                            return
                        }
                        do {
                            let error = try JSONDecoder().decode(ErrorModel.self, from: data)
                            promise(.failure(error))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func sendRequest<T:Decodable>(route: ApiRouter, showLoad:Bool = true, _ success: @escaping (T?) -> Void, _ failure: @escaping (Error) -> Void) {
        if showLoad {
            SVProgressHUD.show()
        }
        session.request(route)
            .responseJSON { (response) in
                if showLoad {
                    SVProgressHUD.dismiss()
                }
                
                if response.response?.statusCode == 200 && response.result.value == nil {
                    success(nil)
                    return
                }
                
                switch response.result {
                case .success:
                    //----LOGGING----
                    self.log(route, response)
                    
                    guard let data = response.data else {
                        failure(response.error!)
                        return
                    }
                    
                    do {
                        var errorObject = try JSONDecoder().decode(ErrorModel.self, from: data)
                        errorObject.errorCode = response.response?.statusCode
                        failure(errorObject)
                        return
                    }catch{
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            success(object)
                            return
                        }catch{
                            success(nil)
                            return
                        }
                    }
                case .failure:
                    //----LOGGING----
                    self.log(route, response)
                    
                    guard let data = response.data else {
                        failure(response.error!)
                        return
                    }
                    
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        success(object)
                        return
                    }catch{
                        do {
                            var errorObject = try JSONDecoder().decode(ErrorModel.self, from: data)
                            errorObject.errorCode = response.response?.statusCode
                            failure(errorObject)
                            return
                        }catch{
                            failure(error)
                            return
                        }
                    }
                }
            }
    }
    
    func sendRequestData(route: ApiRouter, showLoad:Bool = true, _ success: @escaping (Data?) -> Void, _ failure: @escaping (Error) -> Void) {
        if showLoad {
            SVProgressHUD.show()
        }
        session.request(route).responseData { (response) in
            if showLoad {
                SVProgressHUD.dismiss()
            }
            
            if response.response?.statusCode == 200 && response.result.value == nil {
                success(nil)
                return
            }
            
            
            switch response.result {
            case .success:
                
                guard let data = response.data else {
                    failure(response.error!)
                    return
                }
                success(response.data)
            case .failure:
                
                guard let data = response.data else {
                    failure(response.error!)
                    return
                }
            }
        }
    }
    
    func downloadFile (_ urlString:String,  _ success: @escaping (URL?) -> Void, _ failure: @escaping (Error) -> Void) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)

        session.download("change this").downloadProgress(closure: { (progress) in
            
        }).response(completionHandler: { (response) in
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        })
    }
    
    func download(_ urlConvertible: URLRequestConvertible,  _ success: @escaping (String?, URL?) -> Void, _ failure: @escaping (Error) -> Void) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .allDomainsMask, options: [.removePreviousFile])
        
        session.download(urlConvertible, to: destination).response() { (response) in
            self.log(urlConvertible, response: response)
            switch response.result {
            case .success(let url):
                success(response.response?.suggestedFilename, url)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

//MARK: - Logging
extension ApiClient {
    func log(_ route:URLRequestConvertible, _ response:DataResponse<Any>) {
        print("------------------START REQUEST---------------------------")
        print("-> URL REQUEST: ", route.urlRequest?.url?.absoluteString ?? "")
        print("-> API HEADERS: ", route.urlRequest?.allHTTPHeaderFields?.toData()?.prettyPrintedJSONString ?? "")
        print("-> METHOD: ", route.urlRequest?.httpMethod ?? "")
        let body = route.urlRequest.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        print("-> API BODY: ", body)
        
        print("<- STATUS CODE: ", response.response?.statusCode ?? "")
        
        if let urlResponseString = route.urlRequest?.url?.absoluteString {
            print("<- RESPONSE FROM URL: ", urlResponseString)
        }
        if let header = response.response?.allHeaderFields as? [String:Any] {
            print("<- RESPONSE HEADER: ", header.toData()?.prettyPrintedJSONString ?? "")
        }
        print("<- RESPONSE: ", response.data?.prettyPrintedJSONString ?? "")
        print("------------------END REQUEST----------------------------")
    }
    
    func log(_ route:URLRequestConvertible, response: DownloadResponse<URL?>) {
        print("------------------START REQUEST---------------------------")
        print("-> URL REQUEST: ", route.urlRequest?.url?.absoluteString ?? "")
        print("-> API HEADERS: ", route.urlRequest?.allHTTPHeaderFields?.toData()?.prettyPrintedJSONString ?? "")
        print("-> METHOD: ", route.urlRequest?.httpMethod ?? "")
        let body = route.urlRequest.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "-"
        print("-> API BODY: ", body)
        print("<- STATUS CODE: ", response.response?.statusCode ?? "")
        
        if let urlResponseString = route.urlRequest?.url?.absoluteString {
            print("<- RESPONSE FROM URL: ", urlResponseString)
        }
        if let header = response.response?.allHeaderFields as? [String:Any] {
            print("<- RESPONSE HEADER: ", header.toData()?.prettyPrintedJSONString ?? "")
        }
        print("<- RESPONSE: ", response.fileURL ?? "")
        print("------------------END REQUEST----------------------------")
    }
}
