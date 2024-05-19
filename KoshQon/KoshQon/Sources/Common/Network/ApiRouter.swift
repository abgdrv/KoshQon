//
//  ApiRouter.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.05.2024.
//

import Foundation
import Alamofire

enum ApiRouter : URLRequestConvertible {
    
    //MARK: - Authorization
    case verifyOtp(String, String)
    case registerDevice(String, Int)
    
    //MARK: - Profile
    case profile
    
    //MARK: - Programs
    case programs
    case programsInfo(String)
    
    //MARK: - MedNetwork
    case medNetwork(String, String?)
    
    //MARK: - Cities
    case cities

    //MARK: - Family
    case family(String)
    
    //MARK: - Contacts
    case contacts
    
    //MARK: - News
    case news
    
    //MARK: - Notification
    case notification
    case notificationDetail(String)
    
    //MARK: ------HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .verifyOtp, .registerDevice:
            return .post
        case .profile, .programs, .programsInfo, .medNetwork, .cities, .family, .contacts, .news, .notification, .notificationDetail:
            return .get
        }
    }
    
    //MARK: ------Path
    private var path: String {
        switch self {
        
            //MARK: - Authorization
        case .verifyOtp:
            return "v1/auth/verifyOtp"
        case .registerDevice:
            return "/v1/auth/AddDevice"
 
            //MARK: - Profile
        case .profile:
            return "v1/client/profile"
            
            //MARK: - Programs
        case .programs:
            return "v1/client/programs"
        case .programsInfo(let id):
            return "v1/client/programs/\(id)"
            
            //MARK: - MedNetwork
        case .medNetwork(let programId, _):
            return "v1/medical_network/\(programId)"
            
            //MARK: - Cities
        case .cities:
            return "v1/cities"
            
            //MARK: - History
            
            //MARK: - Family
        case .family:
            return "v1/client/family"
            
            //MARK: - Contacts
        case .contacts:
            return "v1/contacts"
            
            //MARK: - News
        case .news:
            return "v1/news"
            
            //MARK: - Notification
        case .notification:
            return "v1/notifications"
        case .notificationDetail(let id):
            return "v1/notifications/\(id)"
        }
    }
    
    //MARK: ------Parameters
    private var parameters: [String:Any]? {
        switch self {
            
            //MARK: - Authorization
        case .verifyOtp(let phoneNumber, let otp):
            return ["phoneNumber": phoneNumber,
                    "otp": otp]
        case .registerDevice(let deviceId, let deviceType):
            return ["deviceId": deviceId,
                    "deviceType": deviceType]
            
            //MARK: - MedNetwork
        case .medNetwork(_, let cityId):
            if let cityId = cityId {
                return ["cityId": cityId]
            }
            return [:]
            
            //MARK: - Family
        case .family(let programId):
            return ["programId": programId]
        
        default:
            return [:]
        }
    }

    //MARK: ------URLRequest - HEADERS
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.url.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
//        urlRequest.setValue(ApiClient.shared.authToken ?? "",
//                            forHTTPHeaderField: Constants.HttpHeaderField.authorization.rawValue)
//        urlRequest.setValue(Constants.ContentType.json.rawValue,
//                            forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
//        urlRequest.setValue(Constants.deviceUid(),
//                            forHTTPHeaderField: Constants.HttpHeaderField.device_uid.rawValue)
//        urlRequest.setValue(ApiClient.shared.notificationToken ?? "",
//                            forHTTPHeaderField: Constants.HttpHeaderField.device_push_token.rawValue)
//        urlRequest.setValue(Constants.deviceModel(),
//                            forHTTPHeaderField: Constants.HttpHeaderField.device_model.rawValue)
//        urlRequest.setValue(Constants.deviceOS(),
//                            forHTTPHeaderField: Constants.HttpHeaderField.device_os.rawValue)
//        urlRequest.setValue(Constants.deviceOsVersion(),
//                            forHTTPHeaderField: Constants.HttpHeaderField.device_os_version.rawValue)
//        urlRequest.setValue(Constants.appVersion(),
//                            forHTTPHeaderField: Constants.HttpHeaderField.app_version.rawValue)
//        urlRequest.setValue(ApiClient.shared.chosenLanguage().serverLang,
//                            forHTTPHeaderField: Constants.HttpHeaderField.acceptLanguage.rawValue)
//        urlRequest.setValue(Constants.ContentType.brandIBT.rawValue,
//                            forHTTPHeaderField: Constants.HttpHeaderField.brand.rawValue)
        
//        switch self {
//        case .verifyOtp:
//            urlRequest.setValue(Constants.ContentType.json.rawValue,
//                                forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
//        default:
//            break
//        }
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .patch, .delete:
                return URLEncoding.default
            default:
                return URLEncoding.httpBody
            }
        }()
        
        switch self {
//        case .status:
//            return try URLEncoding(destination: .queryString).encode(urlRequest, with: parameters)
//        case .refundRequest, .sendOtp, .verifyOtp:
//            urlRequest.httpBody = parameters?.toData()
//            return try URLEncoding.httpBody.encode(urlRequest, with: nil)
        default:
            return try encoding.encode(urlRequest, with: parameters)
        }
    }
}
