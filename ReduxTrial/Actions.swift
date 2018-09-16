//
//  Actions.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

struct IncreaseByOneAction: Action {
    let reduce: Reducer = { (state: State) in
        return state.mutate(counter: state.counter + 1)
    }
}

struct DecreaseByOneAction: Action {
    let reduce: Reducer = { (state: State) in
        return state.mutate(counter: state.counter - 1)
    }
}
