//
//  TopMixCollectionViewCell.swift
//  AzazelUI
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import UIKit
import SnapKit
import Kingfisher

final public class TopMixCollectionViewCell: UICollectionViewCell {
    
    static public var reuseIdentifier: String = "TopMixCollectionViewCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    public func setupCell(imageURL: String, title: String) {
        backImageView.imageFromServerURL(imageURL)
        titleLabel.text = title
        makeElements()
    }
    
    private func makeElements() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurredEffectView.layer.cornerRadius = 20
        blurredEffectView.layer.masksToBounds = true
        blurredEffectView.frame = contentView.bounds
        
        contentView.addSubview(blurredEffectView)
        blurredEffectView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(12)
        }
        
        blurredEffectView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(7)
            make.width.equalTo(97)
        }
        
        let playImageView = UIImageView(image: UIImage(named: "play"))
        
        blurredEffectView.contentView.addSubview(playImageView)
        playImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(27)
            make.right.equalToSuperview().inset(7)
        }
    }
}
