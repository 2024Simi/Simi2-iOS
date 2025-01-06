//
//  HomeRecordViewComponent.swift
//  Home
//
//  Created by 박서연 on 2024/12/10.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class HomeRecordViewComponent: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        backgroundColor = .white
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 8
        backgroundColor = .white
        setupConstraints()
    }
    
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray400
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "아직 기록이 없어요"
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .coolgray400
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainRecordLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘을\n기록해주세요!"
        label.applyFontCase(.semibold(.title3))
        label.textColor = .coolgray900
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .icGrowingHeart
        return image
    }()
}

public extension HomeRecordViewComponent {
    func setupConstraints() {
        backgroundColor = .white
        
        addSubview(circleView)
        addSubview(label)
        addSubview(mainRecordLabel)
        addSubview(heartImage)
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 6),
            circleView.widthAnchor.constraint(equalToConstant: 6),
            label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainRecordLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            mainRecordLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            heartImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            heartImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            heartImage.widthAnchor.constraint(equalToConstant: 80),
            heartImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func updateData(recordColor: UIColor, subLabel: String, mainLabel: String, heart: UIImage) {
        circleView.backgroundColor = recordColor
        label.text = subLabel
        mainRecordLabel.text = mainLabel
        heartImage.image = heart
    }
}
