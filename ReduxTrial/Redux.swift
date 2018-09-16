//
//  SimpleRedux.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation

// Modified version of BRD's Redux implementation for iOS, https://github.com/breadwallet/breadwallet-ios
// WHY? Because a singular global object & unilateral data flow > KVO in iOS

// protocols are the closest things to javascript objects in swift
protocol Action {
    // reducers are tied to actions so this is a neater implementation than reducer files with long switch statements
    var reduce: Reducer { get }
}

// a pure function that receives the old state and returns the new state.
typealias Reducer = (State) -> State
// a pure function that compares old state to new state
typealias Selector = (_ lhs: State, _ rhs: State) -> Bool
// a pure function that is called on state update
typealias StateUpdatedCallback = (State) -> Void
// allows view controllers to use to receive updates when state has changed.

// Restrict Subscriber to classes
protocol Subscriber: class {}

extension Subscriber {
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}

struct Subscription {
    let selector: Selector
    let callback: StateUpdatedCallback
}

