//
//  ProfileView.swift
//  TODOMate
//
//  Created by 이나연 on 5/14/25.
//

import UIKit

import SnapKit
import Then

final class ProfileView: BaseUIView {
    
    // MARK: - UI Components
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .reIconMe
    }

    private let nameLabel = UILabel().then {
        $0.text = "me"
        $0.textColor = .darkgrey20
        $0.font = .body_bold_14
    }
    
    private let aiPlusImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = .reIconAiplus
    }
    
    // MARK: - Custom Method
    
    override func setUI() {
        backgroundColor = .white
        addSubviews(profileImageView, nameLabel, aiPlusImageView)
    }

    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(14)
        }
        
        aiPlusImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
    }
}
