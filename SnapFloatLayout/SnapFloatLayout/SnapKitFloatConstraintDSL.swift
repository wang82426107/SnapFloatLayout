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


public protocol SnapKitFloatConstraintDSL {
    
    var target: AnyObject? { get }
    
    func setLabel(_ value: String?)
    func label() -> String?
    
}
extension SnapKitFloatConstraintDSL {
    
    public func setLabel(_ value: String?) {
        objc_setAssociatedObject(self.target as Any, &labelKey, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    public func label() -> String? {
        return objc_getAssociatedObject(self.target as Any, &labelKey) as? String
    }
    
}
private var labelKey: UInt8 = 0


public protocol SnapKitFloatConstraintBasicAttributesDSL : SnapKitFloatConstraintDSL {
}
extension SnapKitFloatConstraintBasicAttributesDSL {
    
    // MARK: Basics
    
    public var left: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.left)
    }
    
    public var top: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.top)
    }
    
    public var right: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.right)
    }
    
    public var bottom: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.bottom)
    }
    
    public var leading: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.leading)
    }
    
    public var trailing: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.trailing)
    }
    
    public var width: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.width)
    }
    
    public var height: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.height)
    }
    
    public var centerX: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.centerX)
    }
    
    public var centerY: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.centerY)
    }
    
    public var edges: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.edges)
    }
    
    public var directionalEdges: SnapKitFloatConstraintItem {
      return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.directionalEdges)
    }

    public var horizontalEdges: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.horizontalEdges)
    }

    public var verticalEdges: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.verticalEdges)
    }

    public var directionalHorizontalEdges: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.directionalHorizontalEdges)
    }

    public var directionalVerticalEdges: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.directionalVerticalEdges)
    }

    public var size: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.size)
    }
    
    public var center: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.center)
    }
    
}

public protocol SnapKitFloatConstraintAttributesDSL : SnapKitFloatConstraintBasicAttributesDSL {
}
extension SnapKitFloatConstraintAttributesDSL {
    
    // MARK: Baselines
    @available(*, deprecated, renamed:"lastBaseline")
    public var baseline: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.lastBaseline)
    }
    
    @available(iOS 8.0, OSX 10.11, *)
    public var lastBaseline: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.lastBaseline)
    }
    
    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.firstBaseline)
    }
    
    // MARK: Margins
    
    @available(iOS 8.0, *)
    public var leftMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.leftMargin)
    }
    
    @available(iOS 8.0, *)
    public var topMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.topMargin)
    }
    
    @available(iOS 8.0, *)
    public var rightMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.rightMargin)
    }
    
    @available(iOS 8.0, *)
    public var bottomMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.bottomMargin)
    }
    
    @available(iOS 8.0, *)
    public var leadingMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.leadingMargin)
    }
    
    @available(iOS 8.0, *)
    public var trailingMargin: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.trailingMargin)
    }
    
    @available(iOS 8.0, *)
    public var centerXWithinMargins: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.centerXWithinMargins)
    }
    
    @available(iOS 8.0, *)
    public var centerYWithinMargins: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.centerYWithinMargins)
    }
    
    @available(iOS 8.0, *)
    public var margins: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.margins)
    }
    
    @available(iOS 8.0, *)
    public var directionalMargins: SnapKitFloatConstraintItem {
      return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.directionalMargins)
    }

    @available(iOS 8.0, *)
    public var centerWithinMargins: SnapKitFloatConstraintItem {
        return SnapKitFloatConstraintItem(target: self.target, attributes: SnapKitFloatConstraintAttributes.centerWithinMargins)
    }
    
}

