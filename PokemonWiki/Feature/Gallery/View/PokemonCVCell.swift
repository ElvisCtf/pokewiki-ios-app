//
//  PokemonCVCell.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 3/7/2024.
//

import UIKit
import SnapKit

class PokemonCVCell: UICollectionViewCell {
    static let reuseIdentifier = "pokemon_cell"
    
    let cornerRadius = 12.0
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Pokemon"
        lbl.textColor = .label
        lbl.textAlignment = .center
        return lbl
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
        
        contentView.addSubview(nameLbl)
    }
    
    func setLayout() {
        nameLbl.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview().inset(8)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
