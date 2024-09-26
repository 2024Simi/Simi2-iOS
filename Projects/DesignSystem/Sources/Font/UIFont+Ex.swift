//
//  Font+Ex.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/09/25.
//  Copyright © 2024 simi2-2024. All rights reserved.
//

import UIKit

public enum FontCase {
    case bold(SimiFont)
    case semibold(SimiFont)
    case regular(SimiFont)
    
    var name: String {
        switch self {
        case .bold(_):
            return DesignSystemFontFamily.Pretendard.bold.name
        case .semibold(_):
            return DesignSystemFontFamily.Pretendard.semiBold.name
        case .regular(_):
            return DesignSystemFontFamily.Pretendard.regular.name
        }
    }
    
    public var spacing: CGFloat {
        switch self {
        case .bold(_):
            return -0.25
        case .semibold(_):
            return 0
        case .regular(_):
            return 0
        }
    }
    
    public func toUIFont(_ font:  FontCase) -> UIFont? {
        switch font {
        case .bold(let simiFont):
            return UIFont(name: font.name, size: simiFont.size)
        case .semibold(let simiFont):
            return UIFont(name: font.name, size: simiFont.size)
        case .regular(let simiFont):
            return UIFont(name: font.name, size: simiFont.size)
        }
    }
    
    public var toUIFont: UIFont {
        switch self {
        case .bold(let simiFont),
             .semibold(let simiFont),
             .regular(let simiFont):
        return UIFont(name: self.name, size: simiFont.size)!
        }
    }
}

public extension UILabel {
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func applyFontCase(_ fontCase: FontCase) {
        self.font = fontCase.toUIFont
        setLineSpacing(spacing: fontCase.spacing)
    }
}

public enum SimiFont {
    case caption2
    case caption1
    case footnote
    case subheadline
    case callout
    case body
    case title3
    case title2
    case title1
    case largeTitle
    
    public var size: CGFloat {
        switch self {
        case .caption2:
            return 11
        case .caption1:
            return 12
        case .footnote:
            return 13
        case .subheadline:
            return 15
        case .callout:
            return 16
        case .body:
            return 17
        case .title3:
            return 20
        case .title2:
            return 22
        case .title1:
            return 28
        case .largeTitle:
            return 34
        }
    }
}

