//
//  PokemonCVCell.swift
//  PokemonWiki
//
//  Created by Elvis Cheng on 3/7/2024.
//

import UIKit
import SnapKit

class PokemonCVCell: UICollectionViewCell {
    static let reuseIdentifier = "pokemon_cell"
    
    let cornerRadius = 12.0
    let padding = 8.0
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Pokemon"
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.accessibilityIdentifier = "\(type(of: PokemonCVCell.self))_nameLbl"
        return lbl
    }()
    
    let iconIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.accessibilityIdentifier = "\(type(of: PokemonCVCell.self))_iconIV"
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setLayout()
    }
    
    func initUI() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLbl)
    }
    
    func setLayout() {
        iconIV.snp.makeConstraints {
            $0.top.equalToSuperview().inset(padding)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(0)
            $0.width.equalTo(0)
        }
        
        nameLbl.snp.makeConstraints {
            $0.top.equalTo(iconIV.snp.bottom).offset(padding)
            $0.left.bottom.right.equalToSuperview().inset(padding)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    func setContent(name: String?, image: Data?, size: CGSize) {
        nameLbl.text = name
        if let safeImage = image {
            iconIV.snp.updateConstraints {
                $0.height.equalTo(size.height - 2*padding - nameLbl.intrinsicContentSize.height)
                $0.width.equalTo(size.width - 2*padding)
            }
            iconIV.image = UIImage(data: safeImage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
