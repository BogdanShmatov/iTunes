//
//  SearchViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import AzazelUI

class SearchViewController: UIViewController, SearchDataSourceDelegate {

    var dataSource = SearchDataSource()
    
	var presenter: SearchPresenterInput?
    
    private var searchView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Song"
        searchBar.searchBarStyle = .minimal
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecentlyPlayedTableViewCell.self, forCellReuseIdentifier: RecentlyPlayedTableViewCell.reuseIdentifier)
        tableView.register(RecentlyPlayedSceletonTableViewCell.self, forCellReuseIdentifier: RecentlyPlayedSceletonTableViewCell.reuseIdentifier)
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesAndDatasources()
        setupView()
    }
    
    func setupDelegatesAndDatasources() {
        dataSource.delegate = self
        searchView.delegate = dataSource
        tableView.delegate = dataSource
       
        tableView.dataSource = dataSource
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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(36)
        }
    }
}

extension SearchViewController: SearchAssemblable {
    func searchProceed() {
        dataSource.isLoading = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchFailure() {}
}
