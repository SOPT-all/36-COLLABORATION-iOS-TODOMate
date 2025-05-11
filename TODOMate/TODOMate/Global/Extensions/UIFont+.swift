//
//  UIFont+.swift
//  TODOMate
//
//  Created by 이나연 on 5/12/25.
//

import UIKit

extension UIFont {
    enum FontFamaliy {
        case black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin

        var name: String {
            switch self {
            case .black:
                return "Black"
            case .bold:
                return "Bold"
            case .extraBold:
                return "ExtraBold"
            case .extraLight:
                return "ExtraLight"
            case .light:
                return "Light"
            case .medium:
                return "Medium"
            case .regular:
                return "Regular"
            case .semiBold:
                return "SemiBold"
            case .thin:
                return "Thin"
            }
        }
    }
    static func pretendard(_ fontFamily: FontFamaliy, size: CGFloat) -> UIFont {
        guard let pretendardFont = UIFont(name: "Pretendard-\(fontFamily.name)", size: size) else {
            fatalError("폰트를 찾을 수 없어요!")
        }
        return pretendardFont
    }
}
