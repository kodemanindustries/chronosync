//
//  BaseView.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 5/31/18.
//  Copyright © 2018 Kodeman Industries. All rights reserved.
//

import UIKit
import Swinject

/**
 Provides convenience methods to load the subclass of the BaseView's respective .xib.

 This allows for us to define our custom views in a .xib and still use them in another .xib or storyboard. Everything will be drawn in the 'parent' storyboard and also at runtime.

 - important: Should put all code that uses `self` on the right side (i.e. something.delegate = self) in `commonSetup` and NOT in `didSet{}` of an IBOutlet.
 */
open class BaseView: UIView {
    private var internalView: UIView?

    open override class var layerClass: AnyClass {
        return TransformLayer.self
    }

    /**
     Override this function in subclasses to perform common setup during initialization.
     - note: Should put all code that uses `self` on the right side (i.e. something.delegate = self) here.
     */
    open func commonSetup() {

    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    /**
     This should only be overridden in some tests where we need to provide the real nib name rather than the "FakeClassName". By default it will convert the class into its string name.
     - parameter classType: The class which we are getting the nib for.
     - returns: A string representing the class name which should be the nib name.
     */
    internal class func nibName(for classType: UIView.Type) -> String {
        let nibName = String(describing: classType)
        return nibName
    }

    /**
     This should only need to be overridden in some tests where we need to provide the module for the real nib.
     - parameter classType: The class for which we are getting the module name.
     - returns: Module name derived from the class name.
     */
    internal class func moduleName(for classType: UIView.Type) -> String {
        let classString = NSStringFromClass(classType)
        let moduleString = (classString as NSString).components(separatedBy: ".")[0]
        return moduleString
    }

    /**
     The .xib needs to be set up like so:
     File's Owner needs to be set to the subclass of BaseView
     The first view needs to also be set to the subclass of BaseView

     When the .xib is finished loading, the view hierarchy will be like:
     Subclass of BaseView
     |-----> Subclass of BaseView
             |-----> All other subviews
     and all of the outlets will be accessible via self.xyz or self.subviews[0].xyz

     The outlets need to be hooked up to the File's Owner

     - parameter withFilesOwner: The instance of the subclass that will be the File's Owner. Also, we will look in the Bundle that contains this class for the .xib.
     - returns: The first subview from the .xib. This first subview represents the subclass of the `BaseView`
     */
    private class func loadView(withFilesOwner filesOwner: UIView) -> UIView {
        let classType: UIView.Type = type(of: filesOwner)
        let myNibName = nibName(for: classType)

        let moduleString = moduleName(for: classType)
        let desiredClassName = moduleString + "." + myNibName

        var desiredClass: AnyObject.Type
        if let classFromString = NSClassFromString(desiredClassName) {
            desiredClass = classFromString
        }
        else {
            desiredClass = classType
        }

        let bundle = Bundle(for: desiredClass)
        guard let loadedNibObjects = bundle.loadNibNamed(myNibName, owner: filesOwner, options: nil) else {
            fatalError("Failed to unwrap nib objects for nibName: \(myNibName). Does the nib exist?")
        }

        let firstSubview = loadedNibObjects.first as! UIView
        assert(type(of: firstSubview) == desiredClass, "The type of the first top-level object (\(type(of: firstSubview))) is incorrect. It should be \(desiredClass). Check your .xib.")

        return firstSubview
    }

    required override public init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
        ManualResolver.finishConstruction(me: self)
        commonSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if internalView == nil, subviews.isEmpty {
            initNib()
            ManualResolver.finishConstruction(me: self)
            commonSetup()
        }
    }

    private func initNib() {
        internalView = type(of: self).loadView(withFilesOwner: self)
        guard let topLevelView = internalView else {
            fatalError("internalView was nil so our custom .xib isn't going to load correctly")
        }

        topLevelView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topLevelView)

        NSLayoutConstraint.activate([
            topLevelView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topLevelView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topLevelView.topAnchor.constraint(equalTo: self.topAnchor),
            topLevelView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
