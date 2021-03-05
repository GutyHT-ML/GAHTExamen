//
//  App.swift
//  GAHTExamen
//
//  Created by mac12 on 3/4/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class App: NSObject {
    static let shared = App()
    let defaults = UserDefaults.standard
    var players = [Player]()
}
