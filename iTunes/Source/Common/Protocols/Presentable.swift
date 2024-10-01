//
//  Presentable.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? {get}
}

extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
