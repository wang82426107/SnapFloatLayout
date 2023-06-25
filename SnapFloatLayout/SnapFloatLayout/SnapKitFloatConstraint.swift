//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public final class SnapKitFloatConstraint {

    internal let sourceLocation: (String, UInt)
    internal let label: String?

    private let from: SnapKitFloatConstraintItem
    private let to: SnapKitFloatConstraintItem
    private let relation: SnapKitFloatConstraintRelation
    private let multiplier: SnapKitFloatConstraintMultiplierTarget
    private var constant: SnapKitFloatConstraintConstantTarget {
        didSet {
            self.updateConstantAndPriorityIfNeeded()
        }
    }
    private var priority: SnapKitFloatConstraintPriorityTarget {
        didSet {
          self.updateConstantAndPriorityIfNeeded()
        }
    }
    public var layoutConstraints: [SnapKitFloatLayoutConstraint]
    
    public var isActive: Bool {
        set {
            if newValue {
                activate()
            }
            else {
                deactivate()
            }
        }
        
        get {
            for layoutConstraint in self.layoutConstraints {
                if layoutConstraint.isActive {
                    return true
                }
            }
            return false
        }
    }
    
    // MARK: Initialization

    internal init(from: SnapKitFloatConstraintItem,
                  to: SnapKitFloatConstraintItem,
                  relation: SnapKitFloatConstraintRelation,
                  sourceLocation: (String, UInt),
                  label: String?,
                  multiplier: SnapKitFloatConstraintMultiplierTarget,
                  constant: SnapKitFloatConstraintConstantTarget,
                  priority: SnapKitFloatConstraintPriorityTarget) {
        self.from = from
        self.to = to
        self.relation = relation
        self.sourceLocation = sourceLocation
        self.label = label
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
        self.layoutConstraints = []

        // get attributes
        let layoutFromAttributes = self.from.attributes.layoutAttributes
        let layoutToAttributes = self.to.attributes.layoutAttributes

        // get layout from
        let layoutFrom = self.from.layoutConstraintItem!

        // get relation
        let layoutRelation = self.relation.layoutRelation

        for layoutFromAttribute in layoutFromAttributes {
            // get layout to attribute
            let layoutToAttribute: LayoutAttribute
            #if os(iOS) || os(tvOS)
                if layoutToAttributes.count > 0 {
                    if self.from.attributes == .edges && self.to.attributes == .margins {
                        switch layoutFromAttribute {
                        case .left:
                            layoutToAttribute = .leftMargin
                        case .right:
                            layoutToAttribute = .rightMargin
                        case .top:
                            layoutToAttribute = .topMargin
                        case .bottom:
                            layoutToAttribute = .bottomMargin
                        default:
                            fatalError()
                        }
                    } else if self.from.attributes == .margins && self.to.attributes == .edges {
                        switch layoutFromAttribute {
                        case .leftMargin:
                            layoutToAttribute = .left
                        case .rightMargin:
                            layoutToAttribute = .right
                        case .topMargin:
                            layoutToAttribute = .top
                        case .bottomMargin:
                            layoutToAttribute = .bottom
                        default:
                            fatalError()
                        }
                    } else if self.from.attributes == .directionalEdges && self.to.attributes == .directionalMargins {
                      switch layoutFromAttribute {
                      case .leading:
                        layoutToAttribute = .leadingMargin
                      case .trailing:
                        layoutToAttribute = .trailingMargin
                      case .top:
                        layoutToAttribute = .topMargin
                      case .bottom:
                        layoutToAttribute = .bottomMargin
                      default:
                        fatalError()
                      }
                    } else if self.from.attributes == .directionalMargins && self.to.attributes == .directionalEdges {
                      switch layoutFromAttribute {
                      case .leadingMargin:
                        layoutToAttribute = .leading
                      case .trailingMargin:
                        layoutToAttribute = .trailing
                      case .topMargin:
                        layoutToAttribute = .top
                      case .bottomMargin:
                        layoutToAttribute = .bottom
                      default:
                        fatalError()
                      }
                    } else if self.from.attributes == self.to.attributes {
                        layoutToAttribute = layoutFromAttribute
                    } else {
                        layoutToAttribute = layoutToAttributes[0]
                    }
                } else {
                    if self.to.target == nil && (layoutFromAttribute == .centerX || layoutFromAttribute == .centerY) {
                        layoutToAttribute = layoutFromAttribute == .centerX ? .left : .top
                    } else {
                        layoutToAttribute = layoutFromAttribute
                    }
                }
            #else
                if self.from.attributes == self.to.attributes {
                    layoutToAttribute = layoutFromAttribute
                } else if layoutToAttributes.count > 0 {
                    layoutToAttribute = layoutToAttributes[0]
                } else {
                    layoutToAttribute = layoutFromAttribute
                }
            #endif

            // get layout constant
            let layoutConstant: CGFloat = self.constant.constraintConstantTargetValueFor(layoutAttribute: layoutToAttribute)

            // get layout to
            var layoutTo: AnyObject? = self.to.target

            // use superview if possible
            if layoutTo == nil && layoutToAttribute != .width && layoutToAttribute != .height {
                layoutTo = layoutFrom.superview
            }

            // create layout constraint
            let layoutConstraint = SnapKitFloatLayoutConstraint(
                item: layoutFrom,
                attribute: layoutFromAttribute,
                relatedBy: layoutRelation,
                toItem: layoutTo,
                attribute: layoutToAttribute,
                multiplier: self.multiplier.constraintMultiplierTargetValue,
                constant: layoutConstant
            )

            // set label
            layoutConstraint.label = self.label

            // set priority
            layoutConstraint.priority = LayoutPriority(rawValue: self.priority.constraintPriorityTargetValue)

            // set constraint
            layoutConstraint.constraint = self

            // append
            self.layoutConstraints.append(layoutConstraint)
        }
    }

    // MARK: Public

    @available(*, deprecated, renamed:"activate()")
    public func install() {
        self.activate()
    }

    @available(*, deprecated, renamed:"deactivate()")
    public func uninstall() {
        self.deactivate()
    }

    public func activate() {
        self.activateIfNeeded()
    }

    public func deactivate() {
        self.deactivateIfNeeded()
    }

    @discardableResult
    public func update(offset: SnapKitFloatConstraintOffsetTarget) -> SnapKitFloatConstraint {
        self.constant = offset.constraintOffsetTargetValue
        return self
    }

    @discardableResult
    public func update(inset: SnapKitFloatConstraintInsetTarget) -> SnapKitFloatConstraint {
        self.constant = inset.constraintInsetTargetValue
        return self
    }

    #if os(iOS) || os(tvOS)
    @discardableResult
    @available(iOS 11.0, tvOS 11.0, *)
    public func update(inset: SnapKitFloatConstraintDirectionalInsetTarget) -> SnapKitFloatConstraint {
      self.constant = inset.constraintDirectionalInsetTargetValue
      return self
    }
    #endif

    @discardableResult
    public func update(priority: SnapKitFloatConstraintPriorityTarget) -> SnapKitFloatConstraint {
        self.priority = priority.constraintPriorityTargetValue
        return self
    }

    @discardableResult
    public func update(priority: SnapKitFloatConstraintPriority) -> SnapKitFloatConstraint {
        self.priority = priority.value
        return self
    }

    @available(*, deprecated, renamed:"update(offset:)")
    public func updateOffset(amount: SnapKitFloatConstraintOffsetTarget) -> Void { self.update(offset: amount) }

    @available(*, deprecated, renamed:"update(inset:)")
    public func updateInsets(amount: SnapKitFloatConstraintInsetTarget) -> Void { self.update(inset: amount) }

    @available(*, deprecated, renamed:"update(priority:)")
    public func updatePriority(amount: SnapKitFloatConstraintPriorityTarget) -> Void { self.update(priority: amount) }

    @available(*, deprecated, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityRequired() -> Void {}

    @available(*, deprecated, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityHigh() -> Void { fatalError("Must be implemented by Concrete subclass.") }

    @available(*, deprecated, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityMedium() -> Void { fatalError("Must be implemented by Concrete subclass.") }

    @available(*, deprecated, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityLow() -> Void { fatalError("Must be implemented by Concrete subclass.") }

    // MARK: Internal

    internal func updateConstantAndPriorityIfNeeded() {
        for layoutConstraint in self.layoutConstraints {
            let attribute = (layoutConstraint.secondAttribute == .notAnAttribute) ? layoutConstraint.firstAttribute : layoutConstraint.secondAttribute
            layoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: attribute)

            let requiredPriority = SnapKitFloatConstraintPriority.required.value
            if (layoutConstraint.priority.rawValue < requiredPriority), (self.priority.constraintPriorityTargetValue != requiredPriority) {
                layoutConstraint.priority = LayoutPriority(rawValue: self.priority.constraintPriorityTargetValue)
            }
        }
    }

    internal func activateIfNeeded(updatingExisting: Bool = false) {
        guard let item = self.from.layoutConstraintItem else {
            print("WARNING: SnapKit failed to get from item from constraint. Activate will be a no-op.")
            return
        }
        let layoutConstraints = self.layoutConstraints

        if updatingExisting {
            var existingLayoutConstraints: [SnapKitFloatLayoutConstraint] = []
            for constraint in item.constraints {
                existingLayoutConstraints += constraint.layoutConstraints
            }

            for layoutConstraint in layoutConstraints {
                let existingLayoutConstraint = existingLayoutConstraints.first { $0 == layoutConstraint }
                guard let updateLayoutConstraint = existingLayoutConstraint else {
                    fatalError("Updated constraint could not find existing matching constraint to update: \(layoutConstraint)")
                }

                let updateLayoutAttribute = (updateLayoutConstraint.secondAttribute == .notAnAttribute) ? updateLayoutConstraint.firstAttribute : updateLayoutConstraint.secondAttribute
                updateLayoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: updateLayoutAttribute)
            }
        } else {
            NSLayoutConstraint.activate(layoutConstraints)
            item.add(constraints: [self])
        }
    }

    internal func deactivateIfNeeded() {
        guard let item = self.from.layoutConstraintItem else {
            print("WARNING: SnapKit failed to get from item from constraint. Deactivate will be a no-op.")
            return
        }
        let layoutConstraints = self.layoutConstraints
        NSLayoutConstraint.deactivate(layoutConstraints)
        item.remove(constraints: [self])
    }
}
