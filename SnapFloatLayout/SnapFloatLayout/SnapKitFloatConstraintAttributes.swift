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


internal struct SnapKitFloatConstraintAttributes : OptionSet, ExpressibleByIntegerLiteral {
    
    typealias IntegerLiteralType = UInt
    
    internal init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    internal init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
    internal init(nilLiteral: ()) {
        self.rawValue = 0
    }
    internal init(integerLiteral rawValue: IntegerLiteralType) {
        self.init(rawValue: rawValue)
    }
    
    internal private(set) var rawValue: UInt
    internal static var allZeros: SnapKitFloatConstraintAttributes { return 0 }
    internal static func convertFromNilLiteral() -> SnapKitFloatConstraintAttributes { return 0 }
    internal var boolValue: Bool { return self.rawValue != 0 }
    
    internal func toRaw() -> UInt { return self.rawValue }
    internal static func fromRaw(_ raw: UInt) -> SnapKitFloatConstraintAttributes? { return self.init(raw) }
    internal static func fromMask(_ raw: UInt) -> SnapKitFloatConstraintAttributes { return self.init(raw) }
    
    // normal
    
    internal static let none: SnapKitFloatConstraintAttributes = 0
    internal static let left: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 0)
    internal static let top: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 1)
    internal static let right: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 2)
    internal static let bottom: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 3)
    internal static let leading: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 4)
    internal static let trailing: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 5)
    internal static let width: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 6)
    internal static let height: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 7)
    internal static let centerX: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 8)
    internal static let centerY: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 9)
    internal static let lastBaseline: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 10)
    
    @available(iOS 8.0, OSX 10.11, *)
    internal static let firstBaseline: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 11)

    @available(iOS 8.0, *)
    internal static let leftMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 12)

    @available(iOS 8.0, *)
    internal static let rightMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 13)

    @available(iOS 8.0, *)
    internal static let topMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 14)

    @available(iOS 8.0, *)
    internal static let bottomMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 15)

    @available(iOS 8.0, *)
    internal static let leadingMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 16)

    @available(iOS 8.0, *)
    internal static let trailingMargin: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 17)

    @available(iOS 8.0, *)
    internal static let centerXWithinMargins: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 18)

    @available(iOS 8.0, *)
    internal static let centerYWithinMargins: SnapKitFloatConstraintAttributes = SnapKitFloatConstraintAttributes(UInt(1) << 19)
    
    // aggregates
    
    internal static let edges: SnapKitFloatConstraintAttributes = [.horizontalEdges, .verticalEdges]
    internal static let horizontalEdges: SnapKitFloatConstraintAttributes = [.left, .right]
    internal static let verticalEdges: SnapKitFloatConstraintAttributes = [.top, .bottom]
    internal static let directionalEdges: SnapKitFloatConstraintAttributes = [.directionalHorizontalEdges, .directionalVerticalEdges]
    internal static let directionalHorizontalEdges: SnapKitFloatConstraintAttributes = [.leading, .trailing]
    internal static let directionalVerticalEdges: SnapKitFloatConstraintAttributes = [.top, .bottom]
    internal static let size: SnapKitFloatConstraintAttributes = [.width, .height]
    internal static let center: SnapKitFloatConstraintAttributes = [.centerX, .centerY]

    @available(iOS 8.0, *)
    internal static let margins: SnapKitFloatConstraintAttributes = [.leftMargin, .topMargin, .rightMargin, .bottomMargin]

    @available(iOS 8.0, *)
    internal static let directionalMargins: SnapKitFloatConstraintAttributes = [.leadingMargin, .topMargin, .trailingMargin, .bottomMargin]

    @available(iOS 8.0, *)
    internal static let centerWithinMargins: SnapKitFloatConstraintAttributes = [.centerXWithinMargins, .centerYWithinMargins]
    
    internal var layoutAttributes:[LayoutAttribute] {
        var attrs = [LayoutAttribute]()
        if (self.contains(SnapKitFloatConstraintAttributes.left)) {
            attrs.append(.left)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.top)) {
            attrs.append(.top)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.right)) {
            attrs.append(.right)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.bottom)) {
            attrs.append(.bottom)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.leading)) {
            attrs.append(.leading)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.trailing)) {
            attrs.append(.trailing)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.width)) {
            attrs.append(.width)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.height)) {
            attrs.append(.height)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.centerX)) {
            attrs.append(.centerX)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.centerY)) {
            attrs.append(.centerY)
        }
        if (self.contains(SnapKitFloatConstraintAttributes.lastBaseline)) {
            attrs.append(.lastBaseline)
        }
        
        #if os(iOS) || os(tvOS)
            if (self.contains(SnapKitFloatConstraintAttributes.firstBaseline)) {
                attrs.append(.firstBaseline)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.leftMargin)) {
                attrs.append(.leftMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.rightMargin)) {
                attrs.append(.rightMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.topMargin)) {
                attrs.append(.topMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.bottomMargin)) {
                attrs.append(.bottomMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.leadingMargin)) {
                attrs.append(.leadingMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.trailingMargin)) {
                attrs.append(.trailingMargin)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.centerXWithinMargins)) {
                attrs.append(.centerXWithinMargins)
            }
            if (self.contains(SnapKitFloatConstraintAttributes.centerYWithinMargins)) {
                attrs.append(.centerYWithinMargins)
            }
        #endif
        
        return attrs
    }
}

internal func + (left: SnapKitFloatConstraintAttributes, right: SnapKitFloatConstraintAttributes) -> SnapKitFloatConstraintAttributes {
    return left.union(right)
}

internal func +=(left: inout SnapKitFloatConstraintAttributes, right: SnapKitFloatConstraintAttributes) {
    left.formUnion(right)
}

internal func -=(left: inout SnapKitFloatConstraintAttributes, right: SnapKitFloatConstraintAttributes) {
    left.subtract(right)
}

internal func ==(left: SnapKitFloatConstraintAttributes, right: SnapKitFloatConstraintAttributes) -> Bool {
    return left.rawValue == right.rawValue
}
