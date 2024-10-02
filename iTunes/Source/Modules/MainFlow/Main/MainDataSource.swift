//
//  MainDataSource.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import UIKit

protocol MainDataSourceDelegate: AnyObject {
    var presenter: MainPresenterInput? { get }
    var tableView: UITableView { get }
}

final class MainDataSource: NSObject {
    
    weak var delegate: MainDataSourceDelegate?
}

// MARK: - MainDataSource && UITableViewDataSource
extension MainDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - MainDataSource && UITableViewDelegate
extension MainDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
