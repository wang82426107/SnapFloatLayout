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


public class SnapKitFloatConstraintDescription {
    
    internal let item: SnapKitFloatLayoutConstraintItem
    internal var attributes: SnapKitFloatConstraintAttributes
    internal var relation: SnapKitFloatConstraintRelation? = nil
    internal var sourceLocation: (String, UInt)? = nil
    internal var label: String? = nil
    internal var related: SnapKitFloatConstraintItem? = nil
    internal var multiplier: SnapKitFloatConstraintMultiplierTarget = 1.0
    internal var constant: SnapKitFloatConstraintConstantTarget = 0.0
    internal var priority: SnapKitFloatConstraintPriorityTarget = 1000.0
    internal lazy var constraint: SnapKitFloatConstraint? = {
        guard let relation = self.relation,
              let related = self.related,
              let sourceLocation = self.sourceLocation else {
            return nil
        }
        let from = SnapKitFloatConstraintItem(target: self.item, attributes: self.attributes)
        
        return SnapKitFloatConstraint(
            from: from,
            to: related,
            relation: relation,
            sourceLocation: sourceLocation,
            label: self.label,
            multiplier: self.multiplier,
            constant: self.constant,
            priority: self.priority
        )
    }()
    
    // MARK: Initialization
    
    internal init(item: SnapKitFloatLayoutConstraintItem, attributes: SnapKitFloatConstraintAttributes) {
        self.item = item
        self.attributes = attributes
    }
    
}
