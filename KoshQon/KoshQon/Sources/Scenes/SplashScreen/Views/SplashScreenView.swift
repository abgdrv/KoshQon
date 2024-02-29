//
//  SplashScreenView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var shouldTransition = false
    @State private var font = Font(AppFont.anta.s32)
    
    private let minScaleFont = Font(AppFont.anta.s10)
    private let maxScaleFont = Font(AppFont.anta.s64)
    
    private let maxScaleEffect = 4.0
    private let minScaleEffect = 0.0
    private let animationDuration = 1.0
    private let animationDelay = 1.5
    
    private let color = Color(AppColor.Static.orange.uiColor)
    private let logoColor = Color(AppColor.Theme.mainTitle.uiColor)
    
    private let version = 1.0
    private let versionFont = Font(AppFont.medium.s20)
    
    private let logoName = "KoshQon"
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                backgroundEffectView
                logoView
            }
            Spacer()
            versionView
        }
    }
    
    var backgroundEffectView: some View {
        Circle()
            .fill(color)
            .scaleEffect(shouldTransition ? maxScaleEffect : minScaleEffect)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        shouldTransition = true
                    }
                }
            }
    }
    
    var logoView: some View {
        Text(logoName)
            .font(font)
            .foregroundColor(logoColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.spring(response: 1, dampingFraction: 0.5)) {
                        font = minScaleFont
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                    withAnimation(.spring(response: 1, dampingFraction: 0.5)) {
                        font = maxScaleFont
                    }
                }
            }
    }
    
    var versionView: some View {
        Text("\(version.convertedToString) версия")
            .font(versionFont)
            .foregroundColor(logoColor.opacity(0.4))
    }
}


#Preview {
    SplashScreenView()
}
