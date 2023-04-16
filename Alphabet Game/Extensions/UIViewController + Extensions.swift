//
//  UIViewController + Extensions.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

extension UIViewController{
    class func create(storyboard: String) -> Self {
        return createFromStoryboard(storyboard: storyboard)
    }

    private class func createFromStoryboard<T>(storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
    func dismissVC(animated: Bool = true) {
        presentingViewController?.dismiss(animated: animated, completion: nil)
    }
    
    func popVC(animated: Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
    }
    
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func push(_ controller: UIViewController) {
        if let navVC = self as? UINavigationController {
            navVC.pushViewController(controller, animated: true)
        } else {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showOneButtonAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }

    func showOneButtonAlertWithCallBack(withTitle title: String, withMessage message: String, completion: @escaping (()->())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            completion()
        }
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showTwoButtonsAlert(withTitle title: String, withMessage message:String, rightButtonAction: (()->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(cancel)
        let openSettings = UIAlertAction(title: "Open Settings", style: .default, handler: { action in
            rightButtonAction?()
        })
        alert.addAction(openSettings)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
