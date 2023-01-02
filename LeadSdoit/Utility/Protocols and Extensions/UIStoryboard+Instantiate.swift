//
//  UIStoryboard+Instantiate.swift
//  LeadSdoit
//
//  Created by Илья Петров on 01.01.2023.
//

import UIKit

// Storyboards
enum Storyboard: String {
    case gameVC = "GameVC"
}

extension UIStoryboard {

    convenience init(_ story: Storyboard) {
        self.init(name: story.rawValue, bundle: nil)
    }

    func instantiateController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier\(T.identifier)")
        }
        return viewController
    }
}

protocol StoryboardInstantiable: AnyObject {}

extension StoryboardInstantiable where Self: UIViewController {

    static func instantiateFromStoryboard() -> Self {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)

        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: storyboardName
        ) as? Self else {
            fatalError("Could not instantiate view controller from storyboard \(storyboardName)")
        }

        return viewController
    }
}
