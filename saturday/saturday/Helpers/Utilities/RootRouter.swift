//
//  RootRouter.swift
//  saturday
//
//  Copyright © none. All rights reserved.
//

import UIKit

class RootRouter {

    /** Replaces root view controller. You can specify the replacment animation type.
     If no animation type is specified, there is no animation */
    func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("No window in app")
        }
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = controller
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = controller
        }
    }

    func loadMainAppStructure() {
        // Customize your app structure here
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.red
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }

    func loadMainAppStructureWithStoryboard() {
        // Customize your app structure here
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Could not find initial ViewController")
        }
        setRootViewController(controller: initialViewController, animatedWithOptions: nil)
    }
}
