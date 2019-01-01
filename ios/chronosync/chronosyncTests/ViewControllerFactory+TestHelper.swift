import Foundation

import Swinject
import SwinjectStoryboard

@testable import ChronoSync

extension ViewControllerFactory {
    /**
     This function returns a view controller that is contained in a storyboard. It requires that the storyboard has the same name as the class.

     - parameter type: The type of the view controller to return; the result will be force casted to this type.
     - parameter container: The container we will use to bind to the storyboard
     - returns: The view controller via `instantiateInitialViewController`
     */
    static public func createViewController<T: AnyObject>(_ type: T.Type, container: Container = SwinjectStoryboard.defaultContainer) -> T {
        let name = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let storyboard = SwinjectStoryboard.create(name: name, bundle: bundle, container: container)
        return forceCast(storyboard.instantiateInitialViewController(), T.self)
    }

    /**
     Returns a view controller of given type, from respective storyboard and identifier.

     - parameter type: The type of the view controller to return; the result will be force casted to this type.
     - parameter storyboardName: The name of the storyboard that contains the view controller of the type in the first parameter.
     - parameter storyboardIdentifer: The storyboard identifier of the view controller in the storyboard of the second parameter.
     - parameter container: The container we will use to bind to the storyboard
     - returns: The view controller via `instantiateViewController(withIdentifier:)`
     */
    static public func createViewController<T: AnyObject>(_ type: T.Type, storyboardName: String, storyboardIdentifer: String, container: Container = SwinjectStoryboard.defaultContainer) -> T {
        let bundle = Bundle(for: T.self)
        let storyboard = SwinjectStoryboard.create(name: storyboardName, bundle: bundle, container: container)
        return forceCast(storyboard.instantiateViewController(withIdentifier: storyboardIdentifer), T.self)
    }

    /**
     Returns a navigation controller assuming that it is the initial view controller in the storyboard.

     - parameter rootViewControllerType: The type of the root view controller of the navigation controller.
     - parameter storyboardName: The name of the storyboard that contains the navigation controller.
     - parameter container: The container we will use to bind to the storyboard
     - returns: A UINavigationController with the desired root view controller
     */
    static public func createNavigationController<T: AnyObject>(_ rootViewControllerType: T.Type, storyboardName: String, container: Container = SwinjectStoryboard.defaultContainer) -> UINavigationController {
        let bundle = Bundle(for: rootViewControllerType)
        let storyboard = SwinjectStoryboard.create(name: storyboardName, bundle: bundle, container: container)
        return forceCast(storyboard.instantiateInitialViewController(), UINavigationController.self)
    }
}
