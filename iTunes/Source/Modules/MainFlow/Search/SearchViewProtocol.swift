//
//  SearchViewProtocol.swift
//  iTunes
//
//  Created Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: BaseViewProtocol {
    var onShowPlayer: ((Song, [Song]) -> Void)? { get set }
}
