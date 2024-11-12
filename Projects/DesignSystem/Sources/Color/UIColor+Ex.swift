//
//  Color.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/09/25.
//  Copyright © 2024 simi2-2024. All rights reserved.
//

import UIKit

public enum appColor {
    case gray900
    case gray800
    case gray700
    case gray600
    case gray500
    case gray400
    case gray300
    case gray200
    case gray100
    case gray50
    
    case systemRed
    case systemBlue
    case systemGreen
    
    case pink900
    case pink800
    case pink700
    case pink600
    case pink500
    case pink400
    case pink300
    case pink200
    case pink100
    case pink50
    case color10
    
    case pureWhite
    case pureBlack
    
    case happy
    case sad
    case angry
    case fear
    case somehow
    case offensive
    
    case coolgray900
    case coolgray800
    case coolgray700
    case coolgray600
    case coolgray500
    case coolgray400
    case coolgray300
    case coolgray200
    case coolgray100
    case coolgray50
    
}

public extension UIColor {
    // MARK: - Gray
    static var gray900: UIColor {
        return DesignSystemAsset.gray900.color
    }
    
    static var gray800: UIColor {
        return DesignSystemAsset.gray800.color
    }
    static var gray700: UIColor {
        return DesignSystemAsset.gray700.color
    }
    static var gray600: UIColor {
        return DesignSystemAsset.gray600.color
    }
    static var gray500: UIColor {
        return DesignSystemAsset.gray500.color
    }
    static var gray400: UIColor {
        return DesignSystemAsset.gray400.color
    }
    static var gray300: UIColor {
        return DesignSystemAsset.gray300.color
    }
    static var gray200: UIColor {
        return DesignSystemAsset.gray200.color
    }
    static var gray100: UIColor {
        return DesignSystemAsset.gray100.color
    }
    static var gray50: UIColor {
        return DesignSystemAsset.gray50.color
    }
    
    // MARK: - CoolGray
    static var coolgray900: UIColor {
        return DesignSystemAsset.coolgray900.color
    }
    
    static var coolgray800: UIColor {
        return DesignSystemAsset.coolgray800.color
    }
    
    static var coolgray700: UIColor {
        return DesignSystemAsset.coolgray700.color
    }
    
    static var coolgray600: UIColor {
        return DesignSystemAsset.coolgray600.color
    }
    
    static var coolgray500: UIColor {
        return DesignSystemAsset.coolgray500.color
    }
    
    static var coolgray400: UIColor {
        return DesignSystemAsset.coolgray400.color
    }
    
    static var coolgray300: UIColor {
        return DesignSystemAsset.coolgray300.color
    }
    
    static var coolgray200: UIColor {
        return DesignSystemAsset.coolgray200.color
    }
    
    static var coolgray100: UIColor {
        return DesignSystemAsset.coolgray100.color
    }
    
    static var coolgray50: UIColor {
        return DesignSystemAsset.coolgray50.color
    }
    
    
    // MARK: - System Color
    static var systemRed: UIColor {
        return DesignSystemAsset.systemRed.color
    }
    static var systemBlue: UIColor {
        return DesignSystemAsset.systemBlue.color
    }
    static var systemGreen: UIColor {
        return DesignSystemAsset.systemGreen.color
    }
    
    // MARK: - White/Black
    static var pureWhite: UIColor {
        return DesignSystemAsset.pureWhite.color
    }
    
    static var pureBlack: UIColor {
        return DesignSystemAsset.pureBlack.color
    }
    
    // MARK: - Character
    static var happy: UIColor {
        return DesignSystemAsset.happy.color
    }
    
    static var offensive: UIColor {
        return DesignSystemAsset.offensive.color
    }
    
    static var sad: UIColor {
        return DesignSystemAsset.sad.color
    }
    
    static var angry: UIColor {
        return DesignSystemAsset.anger.color
    }
    
    static var somehow: UIColor {
        return DesignSystemAsset.somehow.color
    }
    
    static var fear: UIColor {
        return DesignSystemAsset.fear.color
    }
    
    // MARK: - Pink
    static var pink900: UIColor {
        return DesignSystemAsset.pink900.color
    }
    static var pink800: UIColor {
        return DesignSystemAsset.pink800.color
    }
    static var pink700: UIColor {
        return DesignSystemAsset.pink700.color
    }
    static var pink600: UIColor {
        return DesignSystemAsset.pink600.color
    }
    static var pink500: UIColor {
        return DesignSystemAsset.pink500.color
    }
    static var pink400: UIColor {
        return DesignSystemAsset.pink400.color
    }
    static var pink300: UIColor {
        return DesignSystemAsset.pink300.color
    }
    static var pink200: UIColor {
        return DesignSystemAsset.pink200.color
    }
    static var pink100: UIColor {
        return DesignSystemAsset.pink100.color
    }
    static var pink50: UIColor {
        return DesignSystemAsset.pink50.color
    }
    
    static var color10: UIColor {
        return DesignSystemAsset.color10.color
    }
}
