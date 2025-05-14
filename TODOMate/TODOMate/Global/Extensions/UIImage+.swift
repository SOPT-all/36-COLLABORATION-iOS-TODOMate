//
//  UIImage+.swift
//  TODOMate
//
//  Created by 성현주 on 5/14/25.
//

import UIKit

extension UIImage {
    func resize(to size: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        }
    }
}
