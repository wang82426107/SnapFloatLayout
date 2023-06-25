//
//  ViewController.swift
//  SnapFloatLayout
//
//  Created by 王巍栋 on 2023/6/25.
//

import UIKit

class ViewController: UIViewController {

    lazy var firstView: UIView! = {
        var _firstView = UIView()
        _firstView.backgroundColor = UIColor.red
        _firstView.translatesAutoresizingMaskIntoConstraints = false
        return _firstView
    }()
    
    lazy var secondView: UIView! = {
        var _secondView = UIView()
        _secondView.backgroundColor = UIColor.orange
        _secondView.translatesAutoresizingMaskIntoConstraints = false
        return _secondView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.layoutSubViews()
    }
    
    func layoutSubViews() {
        self.firstView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(self.view.snpFloat.left)
            make.width.equalTo(100)
            make.lastFloatConstraint?.offset(80)
            make.nextFloatConstraint?.offset(-30).priority(.low)
        }
        
        self.secondView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.lastFloatConstraint?.offset(8)
            make.nextFloatConstraint?.offset(-8)
        }
        [self.firstView, self.secondView].remakeFloatLayoutConstraints(orientation: .topToBottom, needLastConstraint: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.secondView.isHidden = !self.secondView.isHidden
        self.layoutSubViews()
    }
}

