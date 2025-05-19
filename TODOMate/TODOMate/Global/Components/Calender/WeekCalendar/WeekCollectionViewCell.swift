//
//  WeekCollectionViewCell.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class WeekCollectionViewCell: UICollectionViewCell {
    static let identifier = "WeekCollectionViewCell"
    
    // MARK: - UI Components
    
    private let checkIconButton = UIButton().then {
        $0.setBackgroundImage(.reIconWeekdayUnchecked, for: .normal)
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
    }
    
    private let dayLabel = CalendarDayLabel().then {
        $0.text = "0"
        $0.clipsToBounds = true
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
        [checkIconButton, dayLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        checkIconButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(checkIconButton.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(19)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func changeDayLabelColor(_ index: Int) {
        dayLabel.backgroundColor = .clear
        
        switch index {
        case 5:
            dayLabel.textColor = .blue20
        case 6:
            dayLabel.textColor = .red10
        default:
            dayLabel.textColor = .black
        }
    }
}

extension WeekCollectionViewCell {
    func dataBind(date: String, isSelected: Bool, index: Int) {
        dayLabel.text = date
        
        if isSelected {
            dayLabel.backgroundColor = .black
            dayLabel.layer.cornerRadius = 10
            dayLabel.textColor = .white
        } else {
           changeDayLabelColor(index)
       }
    }
}
