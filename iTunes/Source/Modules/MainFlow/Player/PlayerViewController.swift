//
//  PlayerViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import UIKit
import SwiftUI

class PlayerViewController: UIViewController, PlayerAssemblable {

	var presenter: PlayerPresenterInput?
    
    var selectedSong: Song?
    var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }
    
    func setupSwiftUIView() {
        let playerVC = UIHostingController(rootView: PlayerView(selectedSong: selectedSong, songs: songs))
        
        let playerView = playerVC.view!
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(playerVC)
        view.addSubview(playerView)

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        playerVC.didMove(toParent: self)
    }
}
