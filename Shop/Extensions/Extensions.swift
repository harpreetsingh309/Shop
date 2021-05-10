//
//  Extensions.swift
//  Shop
//
//  Created by macexpert on 10/05/21.
//

import UIKit

// MARK: - UIApplication
extension UIApplication {
    
    class var scene: UIViewController! {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.window?.rootViewController
    }
    
    class var appWindow: UIWindow! {
        return (UIApplication.shared.delegate?.window!)!
    }
    
    class var rootViewController: UIViewController! {
        return self.scene
    }
}
