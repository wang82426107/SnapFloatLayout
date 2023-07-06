//
//  SnapKitFloatLayout.swift
//  cartechmobile
//
//  Created by 王巍栋 on 2023/6/13.
//

import UIKit


public class FloatConstraintMakerExtendable {
    
    var priorityTarget: SnapKitFloatConstraintPriority! = .required
    
    var constant: CGFloat = 0.0
    
    @discardableResult
    public func offset(_ amount: SnapKitFloatConstraintOffsetTarget) -> FloatConstraintMakerExtendable {
        self.constant = amount.constraintOffsetTargetValue
        return self
    }
    
    // 优先级设置
    @discardableResult
    public func priority(_ amount: SnapKitFloatConstraintPriority) -> FloatConstraintMakerExtendable {
        self.priorityTarget = amount
        return self
    }
}

public extension SnapKitFloatConstraintMaker {
    
    // 嵌套结构体
    private struct AssociatedKeys {
        static var lastFloatConstraint = "lastFloatConstraint"
        static var nextFloatConstraint = "nextFloatConstraint"
    }

    var lastFloatConstraint: FloatConstraintMakerExtendable? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.lastFloatConstraint) as? FloatConstraintMakerExtendable
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lastFloatConstraint, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var nextFloatConstraint: FloatConstraintMakerExtendable? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.nextFloatConstraint) as? FloatConstraintMakerExtendable
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.nextFloatConstraint, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}


public extension SnapKitFloatConstraintView {
    typealias FloatLayoutClosure = (_ make: SnapKitFloatConstraintMaker, _ lastView: UIView?, _ nextView: UIView?) -> Void
    
    // 嵌套结构体
    private struct AssociatedKeys {
        static var FloatLayoutClosure = "FloatLayoutClosure"
    }
    
    var floatLayoutClosure: FloatLayoutClosure? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.FloatLayoutClosure) as? FloatLayoutClosure
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.FloatLayoutClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func remakeFloatLayoutConstraints(_ layoutClosure: @escaping FloatLayoutClosure) {
        self.floatLayoutClosure = layoutClosure
    }
}

public extension Array {
    
    enum FloatLayoutOrientation {
        case unknow      // 未知布局方式
        case leftToRight // 从左到右
        case rightToLeft // 从右到左
        case topToBottom // 从上至下
        case bottomToTop // 从下至上
    }
    
    func remakeFloatLayoutConstraints(orientation: FloatLayoutOrientation? = .unknow, needLastConstraint: Bool! = false) {
        // 布局方向为nil 或者 布局方向为unknow 时, 停止布局
        if orientation == nil || orientation == .unknow { return }
        // 数组为空,或者数组元素类型不为UIView类型时,停止布局
        if self.count == 0  { return }
        if let viewArray = self as? Array<SnapKitFloatConstraintView>  {
            // 筛选出合适的视图
            var needRemakeConstraintsViews = [SnapKitFloatConstraintView]()
            for itemView in viewArray {
                // 如果视图没有添加到父视图上不参与布局
                if itemView.superview == nil {
                    itemView.floatLayoutClosure = nil
                    continue;
                }
                // 如果视图隐藏则不参与布局,并且移除相关布局约束
                if itemView.isHidden {
                    itemView.floatLayoutClosure = nil
                    SnapKitFloatConstraintMaker.removeConstraints(item: itemView)
                    continue;
                }
                // 如果视图没有实现浮动布局Block则不参与布局
                if itemView.floatLayoutClosure == nil {
                    continue;
                }
                needRemakeConstraintsViews.append(itemView)
            }
            // 开始布局
            var lastView: SnapKitFloatConstraintView? = nil
            var nextView: SnapKitFloatConstraintView? = nil
            for i in 0 ..< needRemakeConstraintsViews.count {
                let layoutView = needRemakeConstraintsViews[i]
                if i != 0 {
                    lastView = needRemakeConstraintsViews[i - 1]
                } else {
                    lastView = nil
                }
                if i != needRemakeConstraintsViews.count - 1 {
                    nextView = needRemakeConstraintsViews[i + 1]
                } else {
                    nextView = nil
                }
                
                // 调用SnapKit布局闭包回调
                layoutView.translatesAutoresizingMaskIntoConstraints = false
                let constraintMaker = SnapKitFloatConstraintMaker(item: layoutView)
                let lastFloatConstraint = FloatConstraintMakerExtendable()
                let nextFloatConstraint = FloatConstraintMakerExtendable()
                constraintMaker.lastFloatConstraint = lastFloatConstraint
                constraintMaker.nextFloatConstraint = nextFloatConstraint
                layoutView.floatLayoutClosure?(constraintMaker, lastView, nextView)
                
                let superViewLeftConstraintItem = SnapKitFloatConstraintItem(target: layoutView.superview, attributes: SnapKitFloatConstraintAttributes.left)
                let superViewRightConstraintItem = SnapKitFloatConstraintItem(target: layoutView.superview, attributes: SnapKitFloatConstraintAttributes.right)
                let superViewTopConstraintItem = SnapKitFloatConstraintItem(target: layoutView.superview, attributes: SnapKitFloatConstraintAttributes.top)
                let superViewBottomConstraintItem = SnapKitFloatConstraintItem(target: layoutView.superview, attributes: SnapKitFloatConstraintAttributes.bottom)
                
                let lastViewLeftConstraintItem = SnapKitFloatConstraintItem(target: lastView, attributes: SnapKitFloatConstraintAttributes.left)
                let lastViewRightConstraintItem = SnapKitFloatConstraintItem(target: lastView, attributes: SnapKitFloatConstraintAttributes.right)
                let lastViewTopConstraintItem = SnapKitFloatConstraintItem(target: lastView, attributes: SnapKitFloatConstraintAttributes.top)
                let lastViewBottomConstraintItem = SnapKitFloatConstraintItem(target: lastView, attributes: SnapKitFloatConstraintAttributes.bottom)
                
                
                let nextViewLeftConstraintItem = SnapKitFloatConstraintItem(target: nextView, attributes: SnapKitFloatConstraintAttributes.left)
                let nextViewRightConstraintItem = SnapKitFloatConstraintItem(target: nextView, attributes: SnapKitFloatConstraintAttributes.right)
                let nextViewTopConstraintItem = SnapKitFloatConstraintItem(target: nextView, attributes: SnapKitFloatConstraintAttributes.top)
                let nextViewBottomConstraintItem = SnapKitFloatConstraintItem(target: nextView, attributes: SnapKitFloatConstraintAttributes.bottom)
                
                // 移除先前布局并且添加新的布局
                // 移除所有布局
                SnapKitFloatConstraintMaker.removeConstraints(item: layoutView)

                
                // 添加前后约束
                switch orientation {
                case .unknow:
                    break
                    
                case .leftToRight:
                    if lastView == nil {
                        // 左边与父视图布局
                        constraintMaker.left.equalTo(superViewLeftConstraintItem).offset(lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    } else {
                        // 左边与上一个试图的右边进行布局
                        constraintMaker.left.equalTo(lastViewRightConstraintItem).offset(lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    }
                    if needLastConstraint || (!needLastConstraint && i != needRemakeConstraintsViews.count - 1) {
                        if nextView == nil {
                            // 右边与父视图的右边进行布局
                            constraintMaker.right.equalTo(superViewRightConstraintItem).offset(-nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        } else {
                            // 右边与下一个试图的左边进行布局
                            constraintMaker.right.equalTo(nextViewLeftConstraintItem).offset(-nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        }
                    }
                    break
                case .rightToLeft:
                    if needLastConstraint || (!needLastConstraint && i != 0) {
                        if nextView == nil {
                            // 左边与父视图的左边进行布局
                            constraintMaker.left.equalTo(superViewLeftConstraintItem).offset(nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        } else {
                            // 左边边与下一个试图的右边进行布局
                            constraintMaker.left.equalTo(nextViewRightConstraintItem).offset(nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        }
                    }
                    if lastView == nil {
                        // 右边与父视图布局
                        constraintMaker.right.equalTo(superViewRightConstraintItem).offset(-lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    } else {
                        // 右边与上一个试图的左边进行布局
                        constraintMaker.right.equalTo(lastViewLeftConstraintItem).offset(-lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    }
                    break
                case .topToBottom:
                    if lastView == nil {
                        // 上边与父视图布局
                        constraintMaker.top.equalTo(superViewTopConstraintItem).offset(lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    } else {
                        // 上边与上一个试图的下边进行布局
                        constraintMaker.top.equalTo(lastViewBottomConstraintItem).offset(lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    }
                    if needLastConstraint || (!needLastConstraint && i != needRemakeConstraintsViews.count - 1) {
                        if nextView == nil {
                            // 下边与父视图的下边进行布局
                            constraintMaker.bottom.equalTo(superViewBottomConstraintItem).offset(-nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        } else {
                            // 下边与下一个试图的上边进行布局
                            constraintMaker.bottom.equalTo(nextViewTopConstraintItem).offset(-nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        }
                    }
                    break
                case .bottomToTop:
                    if lastView == nil {
                        // 下边与父视图布局
                        constraintMaker.bottom.equalTo(superViewBottomConstraintItem).offset(-lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    } else {
                        // 下边与上一个试图的上边进行布局
                        constraintMaker.bottom.equalTo(lastViewTopConstraintItem).offset(-lastFloatConstraint.constant).priority(lastFloatConstraint.priorityTarget)
                    }
                    
                    if needLastConstraint || (!needLastConstraint && i != 0) {
                        if nextView == nil {
                            // 上边与父视图的上边进行布局
                            constraintMaker.top.equalTo(superViewTopConstraintItem).offset(nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        } else {
                            // 上边与下一个试图的下边进行布局
                            constraintMaker.top.equalTo(nextViewBottomConstraintItem).offset(nextFloatConstraint.constant).priority(nextFloatConstraint.priorityTarget)
                        }
                    }
                    break
                case .none:
                    break
                }
                
                // 部署所有布局
                var constraints: [SnapKitFloatConstraint] = []
                for description in constraintMaker.descriptions {
                    guard let constraint = description.constraint else {
                        continue
                    }
                    constraints.append(constraint)
                }
                for constraint in constraints {
                    constraint.activateIfNeeded(updatingExisting: false)
                }
                
                // 置为nil 防止循环引用
                constraintMaker.lastFloatConstraint = nil
                constraintMaker.nextFloatConstraint = nil
            }
        } else {
            print("停止布局")
        }
    }
}
