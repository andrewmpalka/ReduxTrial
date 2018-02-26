//
//  Reducer.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

// We’ve defined our Reducer as a pure function that receives an action and the old state, and returns the new state.
//typealias Reducer = (_ action: Action, _ state: State?) -> State

public typealias Reducer<ReducerStateType> =
    (_ action: Action, _ state: ReducerStateType?) -> ReducerStateType
