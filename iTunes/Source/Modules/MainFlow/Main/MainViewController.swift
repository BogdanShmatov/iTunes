//
//  MainViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import SnapKit
import AzazelUI

class MainViewController: UIViewController, MainDataSourceDelegate {

    var dataSource = MainDataSource()
    
    var onCompletion: CompletionBlock?
    var onShowSearch: CompletionBlock?

	var presenter: MainPresenterInput?
    
    private var searchView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Song"
        searchBar.searchBarStyle = .minimal
        searchBar.isUserInteractionEnabled = true;
        return searchBar
    }()
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecentlyPlayedTableViewCell.self, forCellReuseIdentifier: RecentlyPlayedTableViewCell.reuseIdentifier)
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView! = {
        let collectionView =  UICollectionView(frame: CGRect.zero,
                                               collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(TopMixCollectionViewCell.self, forCellWithReuseIdentifier: TopMixCollectionViewCell.reuseIdentifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 170,
                                 height: 170)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        return collectionView
    }()
    
    private var topMixLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Mix"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var recentPlayedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recently Played"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
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
        setupGestures()
        loadData()
    }
    
    func setupDelegatesAndDatasources() {
        dataSource.delegate = self
        tableView.delegate = dataSource
        collectionView.delegate = dataSource
       
        tableView.dataSource = dataSource
        collectionView.dataSource = dataSource
    }
    
    func setupView() {
        view.backgroundColor = .white
        self.view.layer.contents = UIImage(named: "main_bg")?.cgImage
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        view.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
        
        view.addSubview(topMixLabel)
        topMixLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(bannerImageView.snp.bottom).offset(36)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topMixLabel.snp.bottom).offset(25)
            make.height.equalTo(200)
        }
        
        view.addSubview(recentPlayedLabel)
        recentPlayedLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(collectionView.snp.bottom).offset(36)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(recentPlayedLabel.snp.bottom).offset(25)
        }
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        searchView.searchTextField.isUserInteractionEnabled = false
        searchView.addGestureRecognizer(tapGesture)
    }
    
    @objc func searchTapped() {
        onShowSearch?()
    }
    
    func loadData() {
        Task {
            await presenter?.searchSongs(by: "adele")
        }
    }
}

extension MainViewController: MainAssemblable {
    func searchProceed() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
    
    func searchFailure() {
        print("fetch filure")
    }
}
