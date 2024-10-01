//
//  OnboardingViewProtocol.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol OnboardingViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
