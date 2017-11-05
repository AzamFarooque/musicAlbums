//
//  StoryboardIdentifiable.swift
//  EventTracker
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque.
//


import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
