//
//  IconImage.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

final class WeekBoxIconImage: UIImageView {
    init(img: UIImage) {
        super.init(frame: .zero)
        self.image = img
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
