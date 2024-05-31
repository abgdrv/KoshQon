//
//  SplashScreenView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var shouldTransition = false
    @State private var font = AppFont.anta.s32.swiftUIFont
    
    private let minScaleFont = AppFont.anta.s10.swiftUIFont
    private let maxScaleFont = AppFont.anta.s64.swiftUIFont
    private let versionFont = AppFont.medium.s20.swiftUIFont
    
    private let maxScaleEffect = 4.0
    private let minScaleEffect = 0.0
    private let animationDuration = 1.0
    private let animationDelay = 0.5
    
    private let color = AppColor.Static.orange.swiftUIColor
    private let logoColor = AppColor.Theme.mainTitle.swiftUIColor
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                Spacer()
                ZStack {
                    backgroundEffectView
                    logoView
                }
                Spacer()
                versionView
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: geometry.size.height / 15, trailing: 0))
            }
        })
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
        Text(Constants.App.name ?? "")
            .font(font)
            .foregroundColor(logoColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
        HStack {
            Text(Constants.App.version ?? "")
            Text(LocalizableKeys.App.version.localized())
        }
        .font(versionFont)
        .foregroundColor(logoColor.opacity(0.5))
    }
}
