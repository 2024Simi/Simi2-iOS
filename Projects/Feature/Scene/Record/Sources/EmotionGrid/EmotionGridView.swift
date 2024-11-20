//
//  EmotionGridView.swift
//  Home
//
//  Created by 박서연 on 2024/11/21.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public class EmotionGridView: UIView {
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (self.bounds.width - 32 - 24) / 3
        
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: cellWidth, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EmotionGridCell.self, forCellWithReuseIdentifier: EmotionGridCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    private func setupConstraints() {
        addSubview(buttonStackView)
        addSubview(collectionView)
    }
    

}

extension EmotionGridView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionGridCell.identifier, for: indexPath) as? EmotionGridCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
