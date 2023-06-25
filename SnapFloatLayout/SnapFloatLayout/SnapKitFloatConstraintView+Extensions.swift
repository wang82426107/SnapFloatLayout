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


public extension SnapKitFloatConstraintView {
    
    @available(*, deprecated, renamed:"snpFloat.left")
    var snp_left: SnapKitFloatConstraintItem { return self.snpFloat.left }
    
    @available(*, deprecated, renamed:"snpFloat.top")
    var snp_top: SnapKitFloatConstraintItem { return self.snpFloat.top }
    
    @available(*, deprecated, renamed:"snpFloat.right")
    var snp_right: SnapKitFloatConstraintItem { return self.snpFloat.right }
    
    @available(*, deprecated, renamed:"snpFloat.bottom")
    var snp_bottom: SnapKitFloatConstraintItem { return self.snpFloat.bottom }
    
    @available(*, deprecated, renamed:"snpFloat.leading")
    var snp_leading: SnapKitFloatConstraintItem { return self.snpFloat.leading }
    
    @available(*, deprecated, renamed:"snpFloat.trailing")
    var snp_trailing: SnapKitFloatConstraintItem { return self.snpFloat.trailing }
    
    @available(*, deprecated, renamed:"snpFloat.width")
    var snp_width: SnapKitFloatConstraintItem { return self.snpFloat.width }
    
    @available(*, deprecated, renamed:"snpFloat.height")
    var snp_height: SnapKitFloatConstraintItem { return self.snpFloat.height }
    
    @available(*, deprecated, renamed:"snpFloat.centerX")
    var snp_centerX: SnapKitFloatConstraintItem { return self.snpFloat.centerX }
    
    @available(*, deprecated, renamed:"snpFloat.centerY")
    var snp_centerY: SnapKitFloatConstraintItem { return self.snpFloat.centerY }
    
    @available(*, deprecated, renamed:"snpFloat.baseline")
    var snp_baseline: SnapKitFloatConstraintItem { return self.snpFloat.baseline }
    
    @available(*, deprecated, renamed:"snpFloat.lastBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var snp_lastBaseline: SnapKitFloatConstraintItem { return self.snpFloat.lastBaseline }
    
    @available(iOS, deprecated, renamed:"snpFloat.firstBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var snp_firstBaseline: SnapKitFloatConstraintItem { return self.snpFloat.firstBaseline }
    
    @available(iOS, deprecated, renamed:"snpFloat.leftMargin")
    @available(iOS 8.0, *)
    var snp_leftMargin: SnapKitFloatConstraintItem { return self.snpFloat.leftMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.topMargin")
    @available(iOS 8.0, *)
    var snp_topMargin: SnapKitFloatConstraintItem { return self.snpFloat.topMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.rightMargin")
    @available(iOS 8.0, *)
    var snp_rightMargin: SnapKitFloatConstraintItem { return self.snpFloat.rightMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.bottomMargin")
    @available(iOS 8.0, *)
    var snp_bottomMargin: SnapKitFloatConstraintItem { return self.snpFloat.bottomMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.leadingMargin")
    @available(iOS 8.0, *)
    var snp_leadingMargin: SnapKitFloatConstraintItem { return self.snpFloat.leadingMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.trailingMargin")
    @available(iOS 8.0, *)
    var snp_trailingMargin: SnapKitFloatConstraintItem { return self.snpFloat.trailingMargin }
    
    @available(iOS, deprecated, renamed:"snpFloat.centerXWithinMargins")
    @available(iOS 8.0, *)
    var snp_centerXWithinMargins: SnapKitFloatConstraintItem { return self.snpFloat.centerXWithinMargins }
    
    @available(iOS, deprecated, renamed:"snpFloat.centerYWithinMargins")
    @available(iOS 8.0, *)
    var snp_centerYWithinMargins: SnapKitFloatConstraintItem { return self.snpFloat.centerYWithinMargins }
    
    @available(*, deprecated, renamed:"snpFloat.edges")
    var snp_edges: SnapKitFloatConstraintItem { return self.snpFloat.edges }
    
    @available(*, deprecated, renamed:"snpFloat.size")
    var snp_size: SnapKitFloatConstraintItem { return self.snpFloat.size }
    
    @available(*, deprecated, renamed:"snpFloat.center")
    var snp_center: SnapKitFloatConstraintItem { return self.snpFloat.center }
    
    @available(iOS, deprecated, renamed:"snpFloat.margins")
    @available(iOS 8.0, *)
    var snp_margins: SnapKitFloatConstraintItem { return self.snpFloat.margins }
    
    @available(iOS, deprecated, renamed:"snpFloat.centerWithinMargins")
    @available(iOS 8.0, *)
    var snp_centerWithinMargins: SnapKitFloatConstraintItem { return self.snpFloat.centerWithinMargins }
    
    @available(*, deprecated, renamed:"snpFloat.prepareConstraints(_:)")
    func snp_prepareConstraints(_ closure: (_ make: SnapKitFloatConstraintMaker) -> Void) -> [SnapKitFloatConstraint] {
        return self.snpFloat.prepareConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snpFloat.makeConstraints(_:)")
    func snp_makeConstraints(_ closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        self.snpFloat.makeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snpFloat.remakeConstraints(_:)")
    func snp_remakeConstraints(_ closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        self.snpFloat.remakeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snpFloat.updateConstraints(_:)")
    func snp_updateConstraints(_ closure: (_ make: SnapKitFloatConstraintMaker) -> Void) {
        self.snpFloat.updateConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"snp.removeConstraints()")
    func snp_removeConstraints() {
        self.snpFloat.removeConstraints()
    }
    
    var snpFloat: SnapKitFloatConstraintViewDSL {
        return SnapKitFloatConstraintViewDSL(view: self)
    }
    
}
