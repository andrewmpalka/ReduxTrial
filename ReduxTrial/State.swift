//
//  State.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 9/14/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation


struct State {
    var counter: Int
}

// functions
extension State {
    static var initial: State {
        return State(counter: 0)
    }
    
    func mutate(counter: Int? = nil) -> State {
        return State(counter: counter ?? self.counter)
    }
}
