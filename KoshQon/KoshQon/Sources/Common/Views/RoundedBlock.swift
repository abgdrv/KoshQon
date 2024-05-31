//
//  RoundedBlock.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import SwiftUI

struct RoundedBlock<Content: View>: View {
    
    private let title: String?
    private let content: () -> Content
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat
    private let cornerRadius: CGFloat
    private let hPadding: CGFloat
    private let vPadding: CGFloat
    private let backgroundColor: Color
    
    init(
        title: String? = nil,
        hPadding: CGFloat = 16,
        vPadding: CGFloat = 16,
        alignment: HorizontalAlignment = .leading,
        spacing: CGFloat = 16,
        cornerRadius: CGFloat = 16,
        backgroundColor: Color = AppColor.Theme.blockBackground.swiftUIColor,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.alignment = alignment
        self.spacing = spacing
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            if let title = title {
                Text(title)
                    .font(AppFont.medium.s20.swiftUIFont)
                    .foregroundStyle(AppColor.Theme.mainTitle.swiftUIColor)
                    .padding(.horizontal, hPadding)
            }
            content()
                .padding(.horizontal, hPadding)
        }
        .padding(.vertical, vPadding)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
    }
}


