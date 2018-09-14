//
//  ReduxStore.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

let appStore = Store(reducer: appReducer, state: nil)

// TODO Implement CoreData persistence, will treat persistance layer-populated fields similar to a webservice
struct AppState: State {
    func jsStyleDescription() -> String {
        // Unimplemented
        return ""
    }
    
    var counter: Int = 0
}

func appReducer(_ action: Action, _ state: State?) -> State {
    var newState = state as? AppState ?? AppState()
    
    switch action {
    case let action as IncreaseAction:
        newState.counter += action.increaseBy
    case let action as DecreaseAction:
        newState.counter -= action.decreaseBy
    default:
        break
    }
    
    return newState
}
