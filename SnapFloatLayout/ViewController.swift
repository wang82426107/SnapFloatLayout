//
//  ViewController.swift
//  SnapFloatLayout
//
//  Created by 王巍栋 on 2023/6/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var firstView: UIView! = {
        var _firstView = UIView()
        _firstView.backgroundColor = UIColor.red
        return _firstView
    }()
    
    lazy var secondView: UIView! = {
        var _secondView = UIView()
        _secondView.backgroundColor = UIColor.orange
        return _secondView
    }()
    
    lazy var thirdView: UIView! = {
        var _thirdView = UIView()
        _thirdView.backgroundColor = UIColor.cyan
        return _thirdView
    }()
    
    lazy var fourthView: UIView! = {
        var _fourthView = UIView()
        _fourthView.backgroundColor = UIColor.lightGray
        return _fourthView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.view.addSubview(thirdView)
        self.view.addSubview(fourthView)
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
        
        self.thirdView.snpFloat.remakeConstraints { make in
            make.left.equalTo(self.firstView.snpFloat.right).offset(30)
            make.width.height.equalTo(100)
            make.top.equalTo(self.firstView)
        }
        
        self.fourthView.snp.remakeConstraints { make in
            make.left.equalTo(self.firstView.snp.right).offset(30)
            make.top.equalTo(self.thirdView.snp.bottom).offset(30)
            make.width.height.equalTo(60)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.secondView.isHidden = !self.secondView.isHidden
        self.layoutSubViews()
    }
}

