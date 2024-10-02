//
//  MainViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainAssemblable, MainDataSourceDelegate {
    
    var dataSource = MainDataSource()
    
    var onCompletion: CompletionBlock?

	var presenter: MainPresenterInput?
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to iTunes"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesAndDatasources()
        setupView()
    }
    
    func setupDelegatesAndDatasources() {
        dataSource.delegate = self
        tableView.delegate = dataSource
        
        tableView.dataSource = dataSource
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
