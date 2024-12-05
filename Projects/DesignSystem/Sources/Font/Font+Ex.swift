//
//  SText.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/12/06.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI

extension Font {
    static func bold(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: size)
    }
    
    static func semiBold(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: size)
    }
    
    static func regular(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: size)
    }
}

public extension FontCase {
    var swiftUIFont: Font {
        switch self {
        case .bold(let simiFont):
            return .bold(simiFont.size)
        case .semibold(let simiFont):
            return .semiBold(simiFont.size)
        case .regular(let simiFont):
            return .regular(simiFont.size)
        }
    }
}


public struct SText: View {
    let title: String
    let fontType: FontCase
    let color: Color?

    public init(
        _ title: String,
        fontType: FontCase,
        color: Color? = Color.gray900
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }

    public var body: some View {
        Text(title)
            .applyFont(font: fontType)
            .foregroundStyle(color ?? Color.gray900)
    }
}


public struct FontModifier: ViewModifier {
    let font: FontCase

    init(font: FontCase) {
        self.font = font
    }
    
    public func body(content: Content) -> some View {
        content
            .font(font.swiftUIFont)
            .lineSpacing(font.spacing)//.lineSpacing)
//            .padding(.vertical, font.lineHeight)
    }
}

extension View {
    public func applyFont(font: FontCase) -> some View {
        modifier(FontModifier(font: font))
    }
}
