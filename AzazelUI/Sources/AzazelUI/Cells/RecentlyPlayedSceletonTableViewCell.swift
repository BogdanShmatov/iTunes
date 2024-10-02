//
//  RecentlyPlayedSceletonTableViewCell.swift
//  AzazelUI
//
//  Created by Bogdan Shmatov on 03.10.2024.
//

import UIKit
import SnapKit
import SkeletonView

final public class RecentlyPlayedSceletonTableViewCell: UITableViewCell {
    
    static public var reuseIdentifier: String = "RecentlyPlayedSceletonTableViewCell"
    
    private var trackTitleView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
    
    private var artistLabelView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
    
    private var logoView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func setupCell() {
        makeElements()
        [logoView, trackTitleView, artistLabelView].forEach({$0.showAnimatedGradientSkeleton()})
    }
    
    private func makeElements() {
        contentView.backgroundColor = .clear
        contentView.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.width.height.equalTo(60)
        }
        contentView.addSubview(trackTitleView)
        trackTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.left.equalTo(logoView.snp.right).offset(20)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(19)
        }
        
        contentView.addSubview(artistLabelView)
        artistLabelView.snp.makeConstraints { make in
            make.top.equalTo(trackTitleView.snp.bottom).offset(2)
            make.left.equalTo(logoView.snp.right).offset(20)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(17)
        }
        
        [logoView, trackTitleView, artistLabelView].forEach({$0.showAnimatedGradientSkeleton()})
    }
}

