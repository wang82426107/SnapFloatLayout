//
//  SnapKitFloatConstraintMaker.swift
//  cartechmobile
//
//  Created by 王巍栋 on 2023/6/21.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class SnapKitFloatConstraintMaker {
    
    public var left: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.left)
    }
    
    public var top: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.top)
    }
    
    public var bottom: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottom)
    }
    
    public var right: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.right)
    }
    
    public var leading: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leading)
    }
    
    public var trailing: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailing)
    }
    
    public var width: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.width)
    }
    
    public var height: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.height)
    }
    
    public var centerX: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerX)
    }
    
    public var centerY: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerY)
    }
    
    @available(*, deprecated, renamed:"lastBaseline")
    public var baseline: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.lastBaseline)
    }
    
    public var lastBaseline: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.lastBaseline)
    }
    
    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.firstBaseline)
    }
    
    @available(iOS 8.0, *)
    public var leftMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leftMargin)
    }
    
    @available(iOS 8.0, *)
    public var rightMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.rightMargin)
    }
    
    @available(iOS 8.0, *)
    public var topMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.topMargin)
    }
    
    @available(iOS 8.0, *)
    public var bottomMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottomMargin)
    }
    
    @available(iOS 8.0, *)
    public var leadingMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leadingMargin)
    }
    
    @available(iOS 8.0, *)
    public var trailingMargin: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailingMargin)
    }
    
    @available(iOS 8.0, *)
    public var centerXWithinMargins: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerXWithinMargins)
    }
    
    @available(iOS 8.0, *)
    public var centerYWithinMargins: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerYWithinMargins)
    }
    
    public var edges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.edges)
    }
    public var horizontalEdges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.horizontalEdges)
    }
    public var verticalEdges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.verticalEdges)
    }
    public var directionalEdges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalEdges)
    }
    public var directionalHorizontalEdges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalHorizontalEdges)
    }
    public var directionalVerticalEdges: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalVerticalEdges)
    }
    public var size: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.size)
    }
    public var center: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.center)
    }
    
    @available(iOS 8.0, *)
    public var margins: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.margins)
    }
    
    @available(iOS 8.0, *)
    public var directionalMargins: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalMargins)
    }

    @available(iOS 8.0, *)
    public var centerWithinMargins: SnapKitFloatConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerWithinMargins)
    }
    
    public let item: SnapKitFloatLayoutConstraintItem
    public var descriptions = [SnapKitFloatConstraintDescription]()
    
    internal init(item: SnapKitFloatLayoutConstraintItem) {
        self.item = item
        self.item.prepare()
    }
    
    internal func makeExtendableWithAttributes(_ attributes: SnapKitFloatConstraintAttributes) -> SnapKitFloatConstraintMakerExtendable {
        let description = SnapKitFloatConstraintDescription(item: self.item, attributes: attributes)
        self.descriptions.append(description)
        return SnapKitFloatConstraintMakerExtendable(description)
    }
    
    internal static func prepareConstraints(item: SnapKitFloatLayoutConstraintItem, closure: (_ make: SnapKitFloatConstraintMaker) -> Void) -> [SnapKitFloatConstraint] {
        let maker = SnapKitFloatConstraintMaker(item: item)
        closure(maker)
        var constraints: [SnapKitFloatConstraint] = []
        for description in maker.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
        return constraints
    }
    
    internal static func makeConstraints(item: SnapKitFloatLayoutConstraintItem, closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: false)
        }
    }
    
    internal static func remakeConstraints(item: SnapKitFloatLayoutConstraintItem, closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        self.removeConstraints(item: item)
        self.makeConstraints(item: item, closure: closure)
    }
    
    internal static func updateConstraints(item: SnapKitFloatLayoutConstraintItem, closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        guard item.constraints.count > 0 else {
            self.makeConstraints(item: item, closure: closure)
            return
        }
        
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: true)
        }
    }
    
    internal static func removeConstraints(item: SnapKitFloatLayoutConstraintItem) {
        let constraints = item.constraints
        for constraint in constraints {
            constraint.deactivateIfNeeded()
        }
    }
    
}
