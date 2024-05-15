//
//  NumberPadView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import SwiftUI

struct NumberPadView: View {
    
    @Binding var passcode: String
    
    private let columns: [GridItem] = [.init(), .init(), .init()]
    
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(1 ... 9, id: \.self){ index in
                NumberView(number: index) { index in
                    addValue(index)
                }
            }
            Spacer()
            NumberView(number: 0) { _ in
                addValue(0)
            }
            NumberView(number: 10) { _ in
                removeValue()
            }
        }
        .foregroundStyle(Color(uiColor: AppColor.Theme.mainTitle.uiColor))
    }
    
    private func addValue(_ value: Int){
        if passcode.count < 4{
            passcode += "\(value)"
        }
    }
    
    private func removeValue(){
        if !passcode.isEmpty{
            passcode.removeLast()
        }
    }
}
