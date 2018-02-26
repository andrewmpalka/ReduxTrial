//
//  SimpleRedux.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

// Simplified version of ReSwift, a Redux implementation for iOS
// WHY? Because a singular global object & unilateral data flow > KVO in iOS and Providers in Android

// protocols are the closest things to javascript objects in swift
protocol Action {
}

protocol State {
    func jsStyleDescription() -> String
}

// a pure function that receives an action and the old state, and returns the new state.
typealias Reducer = (_ action: Action, _ state: State?) -> State

// allows view controllers to use to receive updates when state has changed.
protocol StoreSubscriber {
    func newState(state: State)
}

// When actions are dispatched, Store will take a pure reducer function to create the new state object, which in turn replaces the old one and then notifies subscribers.
class Store {
    let reducer: Reducer
    var state: State?
    var subscribers: [StoreSubscriber] = []
    
    init(reducer: @escaping Reducer, state: State?) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        self.state = reducer(action, state)
        
        subscribers.forEach { $0.newState(state: self.state!) }
    }
    
    func subscribe(_ newSubscriber: StoreSubscriber) {
        subscribers.append(newSubscriber)
    }
}

// TODO: Find a way to make this typed language print state's properties like JS, current implementation would only give property names, not values
extension State where Self: ViewController {
    func jsStyleDescription() -> String {
        let properties = Mirror(reflecting: self).children.flatMap { $0.label }
        return properties.reduce("") { $0 + "\n" + $1 }
    }
}
