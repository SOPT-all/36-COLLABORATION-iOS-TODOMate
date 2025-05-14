//
//  FriendsListCollectionViewCell.swift
//  TODOMate
//
//  Created by 이나연 on 5/14/25.
//

import UIKit

import SnapKit
import Then

final class FriendsListCollectionViewCell: UICollectionViewCell {
    static let identifier = "FriendsListCollectionViewCell"
    
    // MARK: - UI Components
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.textColor = .darkgrey20
        $0.font = .cap_bold_8
        $0.textAlignment = .center
    }
    
    // MARK: - Setup Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [profileImageView, nameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(46)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension FriendsListCollectionViewCell {
    func dataBind(_ itemData: String, isFinal: Bool) {
        nameLabel.text = itemData
        profileImageView.image = isFinal ? .reIconMore : .reIconMe
    }
}
