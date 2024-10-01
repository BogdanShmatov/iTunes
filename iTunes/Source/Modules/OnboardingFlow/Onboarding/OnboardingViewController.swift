//
//  OnboardingViewController.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController, OnboardingAssemblable {
    
    var onCompletion: CompletionBlock?
    
	var presenter: OnboardingPresenterInput?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }
    
    func setupSwiftUIView() {
        let onboardingVC = UIHostingController(rootView: OnboardingView(onCompletion: onCompletion))
        
        let onboardingView = onboardingVC.view!
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(onboardingVC)
        view.addSubview(onboardingView)

        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        onboardingVC.didMove(toParent: self)
    }
}
