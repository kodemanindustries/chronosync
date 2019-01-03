import Foundation
import UIKit

import Swinject
import SwinjectStoryboard

public class StoryBoardProvider {
    private let container: Container
    private var storyboards = NSMapTable<NSString, UIStoryboard>(keyOptions: .copyIn, valueOptions: .weakMemory)

    public init(container: Container) {
        self.container = container
    }

    public func storyboardWithName(_ name: String, inBundle bundle: Bundle? = nil) -> UIStoryboard {
        if let storyboard = storyboards.object(forKey: name as NSString) {
            return storyboard
        }
        let newStoryboard = SwinjectStoryboard.create(name: name, bundle: bundle, container: container)
        storyboards.setObject(newStoryboard, forKey: name as NSString)
        return newStoryboard
    }
}

public class ViewControllerFactory {
    private let storyboardProvider: StoryBoardProvider!

    public init(storyboardProvider: StoryBoardProvider) {
        self.storyboardProvider = storyboardProvider
    }

    /**
     This function returns a view controller that is contained in a storyboard. It requires that the storyboard has the same name as the class and that the view controller is marked as the initial view controller.
     Example: MyViewController must be in MyViewController.storyboard.

     - parameter type: The type of the view controller to return; the result will be force casted to this type.
     */
    public func createViewController<T: AnyObject>(type: T.Type) -> T {
        let name = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let storyboard = storyboardProvider.storyboardWithName(name, inBundle: bundle)
        return forceCast(storyboard.instantiateInitialViewController(), T.self)
    }

    /**
     Returns a view controller of given type, from respective storyboard and identifier.

     - parameter type: The type of the view controller to return; the result will be force casted to this type.
     - parameter storyboardName: The name of the storyboard that contains the view controller of the type in the first parameter.
     - parameter storyboardIdentifier: The storyboard identifier of the view controller in the storyboard of the second parameter.
     */
    public func createViewController<T: AnyObject>(type: T.Type, storyboardName: String, storyboardIdentifer: String) -> T {
        let bundle = Bundle(for: type)
        let storyboard = storyboardProvider.storyboardWithName(storyboardName, inBundle: bundle)
        return forceCast(storyboard.instantiateViewController(withIdentifier: storyboardIdentifer), T.self)
    }

    /**
     Returns a navigation controller assuming that it is the initial view controller in the storyboard.

     - parameter rootViewControllerType: The type of the root view controller of the navigation controller.
     - parameter storyboardName: The name of the storyboard that contains the navigation controller.
     */
    public func createNavigationController<T: AnyObject>(rootViewControllerType: T.Type, storyboardName: String) -> UINavigationController {
        let bundle = Bundle(for: rootViewControllerType)
        let storyboard = storyboardProvider.storyboardWithName(storyboardName, inBundle: bundle)
        return forceCast(storyboard.instantiateInitialViewController(), UINavigationController.self)
    }

    /**
     Returns a navigation controller given a storyboardName and a storyboardIdentifier.

     - parameter rootViewControllerType: The type of the root view controller of the navigation controller.
     - parameter storyboardName: The name of the storyboard that contains the navigation controller.
     - parameter storyboardIdentifier: The name of the storyboard identifier.
     */
    public func createNavigationController<T: AnyObject>(rootViewControllerType: T.Type, storyboardName: String, storyboardIdentifier: String) -> UINavigationController {
        let bundle = Bundle(for: rootViewControllerType)
        let storyboard = storyboardProvider.storyboardWithName(storyboardName, inBundle: bundle)
        return forceCast(storyboard.instantiateViewController(withIdentifier: storyboardIdentifier), UINavigationController.self)
    }
}
