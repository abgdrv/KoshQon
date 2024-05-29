//
//  PasscodeIndicatorView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import SwiftUI

struct PasscodeIndicatorView: View {
    
    @Binding var passcode: String
    
    var body: some View {
        HStack(spacing: 32){
            ForEach(0 ..< 4){ index in
                Circle()
                    .fill(passcode.count > index 
                          ? Color(uiColor: AppColor.Static.orange.uiColor)
                          : Color(uiColor: AppColor.Theme.secondaryBackground.uiColor))
                    .frame(width:20,height: 20)
                    .overlay{
                        Circle()
                            .stroke(.clear)
                    }
            }
        }
    }
}
