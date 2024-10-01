//
//  MainViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainAssemblable {
    
    var onCompletion: CompletionBlock?

	var presenter: MainPresenterInput?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to iTunes"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.title = "iTunes Home"
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
