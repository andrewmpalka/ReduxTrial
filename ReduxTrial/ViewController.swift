//
//  ViewController.swift
//  ReduxTrial
//
//  Created by Andrew Palka on 2/26/18.
//  Copyright © 2018 Andy Palka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Subscriber {
    
    @IBOutlet weak var counterTextView: VerticallyCenteredTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adds ViewController as new subsriber, allows for state updates
        Store.subscribe(self, selector: {(newState: State, oldState: State) -> Bool in
            //change for custom inequality function
            return oldState.counter != newState.counter
        }, callback: { state in
            self.counterTextView.text = String(state.counter)
            })
    }
    
    @IBAction func userClickedPlus(_ sender: Any) {
        Store.dispatch(action: IncreaseByOneAction())
    }
    
    @IBAction func userClickedMinus(_ sender: Any) {
        Store.dispatch(action: DecreaseByOneAction())
    }
}
