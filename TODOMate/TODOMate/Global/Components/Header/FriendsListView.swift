//
//  FreindsCollectionView.swift
//  TODOMate
//
//  Created by 이나연 on 5/14/25.
//

import UIKit

import SnapKit
import Then

final class FriendsListView: BaseUIView {
    
    // MARK: - Properties
    private let friendsList = ["me", ""]
    
    // MARK: - UI Components
    
    private let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Setup Method
    
    override func setUI() {
        addSubviews(listCollectionView)
        setListCollectionViewFlowLayout()
        registerListCollectionViewCell()
    }
    
    override func setLayout() {
        listCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(93)
        }
    }
    
    // MARK: - Private Method
    
    private func registerListCollectionViewCell() {
        listCollectionView.register(FriendsListCollectionViewCell.self, forCellWithReuseIdentifier: FriendsListCollectionViewCell.identifier)
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
    }
    
    private func setListCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let cellHeight: CGFloat = 62
        let spacing: CGFloat = 11
        let cellWidth: CGFloat = 49
       
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.collectionView?.isScrollEnabled = true
        flowLayout.minimumLineSpacing = spacing
        self.listCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}

extension FriendsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsListCollectionViewCell.identifier, for: indexPath) as? FriendsListCollectionViewCell else {
            return FriendsListCollectionViewCell()
        }
        
        let isFinal = indexPath.item == friendsList.count - 1
        cell.dataBind(friendsList[indexPath.item], isFinal: isFinal)
        return cell
    }
}

extension FriendsListView: UICollectionViewDelegate {
    
}
