//
//  MainViewProtocol.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol MainViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
    
    var onShowSearch: CompletionBlock? { get set }
}
