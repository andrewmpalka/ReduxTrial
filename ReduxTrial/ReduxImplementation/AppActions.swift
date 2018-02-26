//
//  Actions.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

struct IncreaseAction: Action {
    let increaseBy: Int
}

struct DecreaseAction: Action {
    let decreaseBy: Int
}
