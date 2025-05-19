//
//  WeekCalendar.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class WeekCalendar: BaseUIView {
    
    // MARK: - Properties
    
    private let formatter = CalendarDateFormatter()
    private var weekDates: [String] = []
    public var selectedDate: String = ""
    private lazy var selectedIndex = formatter.getTodayDay()
    private var offset: Int = 0

    // MARK: - UI Componets
    
    private let weekStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 29
        $0.distribution = .fillEqually
    }
    
    private let mondayLabel = CalendarDayLabel().then {
        $0.text = "월"
    }
    
    private let tuesdayLabel = CalendarDayLabel().then {
        $0.text = "화"
    }
    
    private let wednesdayLabel = CalendarDayLabel().then {
        $0.text = "수"
    }
    
    private let thursdayLabel = CalendarDayLabel().then {
        $0.text = "목"
    }
    
    private let fridayLabel = CalendarDayLabel().then {
        $0.text = "금"
    }
    
    private let saturdayLabel = CalendarDayLabel(weekday: "saturday").then {
        $0.text = "토"
        $0.textColor = .blue20
    }
    
    private let sundayLabel = CalendarDayLabel(weekday: "sunday").then {
        $0.text = "일"
        $0.textColor = .red10
    }
    
    private let weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - SetUp Method
    
    override func setUI() {
        addSubviews(weekStackView, weekCollectionView)
        [mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel].forEach {
            weekStackView.addArrangedSubview($0)
        }
        
        setWeekCollectionViewFlowLayout()
        registerWeekCollectionViewCell()
        setDate(offset)
    }
    
    override func setLayout() {
        weekStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(21)
        }
        
        weekCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.height.equalTo(60)
        }
    }
    
    private func setWeekCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let cellHeight: CGFloat = 39
        let spacing: CGFloat = 35
        let cellWidth: CGFloat = 20
        
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.collectionView?.isScrollEnabled = false
        flowLayout.collectionView?.isUserInteractionEnabled = true
        flowLayout.minimumLineSpacing = spacing
        self.weekCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        
    }
    
    private func registerWeekCollectionViewCell() {
        weekCollectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
        weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
    }
    
    private func setDate(_ offset: Int) {
        weekDates = formatter.getDateStringsOfWeek(offset: offset)
        weekCollectionView.reloadData()
    }
}

extension WeekCalendar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as? WeekCollectionViewCell else {
            return WeekCollectionViewCell()
        }
        
        let date = weekDates[indexPath.item]
        let isSelected = selectedIndex == indexPath.item
        cell.dataBind(date: date, isSelected: isSelected, index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        selectedDate = weekDates[selectedIndex]
        print("선택된 날짜는요", selectedDate)
        weekCollectionView.reloadData()
    }
}

extension WeekCalendar: UICollectionViewDelegate {
}

extension WeekCalendar: WeekBoxMoveButtonDelegate {
    func didTapPreMoveButton() {
        print("전주 보여주세요")
        offset -= 1
        setDate(offset)
    }
    
    func didTapRightMoveButton() {
        print("다음주 보여주세요")
        offset += 1
        setDate(offset)
    }
}
