//
//  PlayerViewProtocol.swift
//  iTunes
//
//  Created Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import UIKit

protocol PlayerViewProtocol: BaseViewProtocol {
    var selectedSong: Song? { get set }
    var songs: [Song] { get set }
}
