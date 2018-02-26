//
//  ViewController.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var counterTextView: VerticallyCenteredTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adds ViewController as new subsriber, allows for state updates
        appStore.subscribe(self)
    }
    
    @IBAction func userClickedPlus(_ sender: Any) {
        appStore.dispatch(action: IncreaseAction(increaseBy: 1))
    }
    
    @IBAction func userClickedMinus(_ sender: Any) {
        appStore.dispatch(action: DecreaseAction(decreaseBy: 1))
    }
    
    // called upon state update
    func newState(state: State) {
        counterTextView.text = "\((state as? AppState)?.counter ?? 0)"
    }
}
