//
//  ReduxStore.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import Foundation


class Store {
    private static let shared = Store()
    private init() {}
    
    private var isClearingSubscriptions = false
    
    //MARK: - Public
    static func dispatch(action: Action) {
        Store.shared.dispatch(action: action)
    }
    
    
    static var state: State {
        return shared.state
    }
    
    static func subscribe(_ subscriber: Subscriber, selector: @escaping Selector, callback: @escaping StateUpdatedCallback) {
        Store.shared.subscribe(subscriber, selector: selector, callback: callback)
    }
    
    static func lazySubscribe(_ subscriber: Subscriber, selector: @escaping Selector, callback: @escaping StateUpdatedCallback) {
        Store.shared.lazySubscribe(subscriber, selector: selector, callback: callback)
    }
    
    static func unsubscribe(_ subscriber: Subscriber) {
        Store.shared.unsubscribe(subscriber)
    }
    
    static func removeAllSubscriptions() {
        Store.shared.removeAllSubscriptions()
    }
    
    //MARK: - Private
    func dispatch(action: Action) {
        assert(Thread.isMainThread)
        state = action.reduce(state)
    }
    
    
    //Subscription callback is immediately called with current State value on subscription
    //and then any time the selected value changes
    func subscribe(_ subscriber: Subscriber, selector: @escaping Selector, callback: @escaping StateUpdatedCallback) {
        lazySubscribe(subscriber, selector: selector, callback: callback)
        callback(state)
    }
    
    //Same as subscribe(), but doesn't call the callback with current state upon subscription
    func lazySubscribe(_ subscriber: Subscriber, selector: @escaping Selector, callback: @escaping StateUpdatedCallback) {
        let key = subscriber.hashValue
        let subscription = Subscription(selector: selector, callback: callback)
        if subscriptions[key] != nil {
            subscriptions[key]?.append(subscription)
        } else {
            subscriptions[key] = [subscription]
        }
    }
    
    func unsubscribe(_ subscriber: Subscriber) {
        guard !isClearingSubscriptions else { return }
        self.subscriptions.removeValue(forKey: subscriber.hashValue)
    }
    
    //MARK: - Private
    private(set) var state = State.initial {
        didSet {
            subscriptions
                .flatMap { $0.value } //Retreive all subscriptions (subscriptions is a dictionary)
                .filter { $0.selector(oldValue, state) }
                .forEach { subscription in
                    DispatchQueue.main.async {
                        subscription.callback(self.state)
                    }
            }
        }
    }
    
    func removeAllSubscriptions() {
        DispatchQueue.main.async {
            // removing the subscription may trigger deinit of the object and a duplicate call to unsubscribe
            self.isClearingSubscriptions = true
            self.subscriptions.removeAll()
        }
    }
    
    // dictionary of subscriber hashvalue and subscriptions associated with subscriber
    private var subscriptions: [Int: [Subscription]] = [:]
}

