//
//  RecentlyPlayedTableViewCell.swift
//  AzazelUI
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import UIKit
import SnapKit
import Kingfisher

final public class RecentlyPlayedTableViewCell: UITableViewCell {
    
    static public var reuseIdentifier: String = "RecentlyPlayedTableViewCell"
    
    private var trackTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.27, green: 0.15, blue: 0.63, alpha: 1.00)
        return label
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    public func setupCell(imageURL: String, track: String, artist: String) {
        logoImageView.imageFromServerURL(imageURL)
        trackTitleLabel.text = track
        artistLabel.text = artist
        
        makeElements()
    }
    
    private func makeElements() {
        contentView.backgroundColor = .clear
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(60)
        }
        contentView.addSubview(trackTitleLabel)
        trackTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.left.equalTo(logoImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(30)
        }
        
        contentView.addSubview(artistLabel)
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackTitleLabel.snp.bottom).offset(2)
            make.left.equalTo(logoImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(30)
        }
    }
}
