//
//  AMKSubStringViewController.swift
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/18.
//  Copyright © 2023 AndyM129. All rights reserved.
//

import UIKit
import AMKCategories

@objc class AMKSubStringViewController: UIViewController {
    
    // MARK: - Deinit
    
    deinit {
        
    }
    
    // MARK: - Init Methods
    
    @objc public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Circle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
        view.backgroundColor = view.backgroundColor ?? UIColor.white
        
        let string = "一二三四五六七八九十1234567890"
        
        let startIndex = string.index(string.startIndex, offsetBy: 1)
        let endIndex = string.index(string.startIndex, offsetBy: 5) // 到下标 12 结束截取
        let subString = string[startIndex..<endIndex]
        print("\(#file.split(separator: "/").last!) \(#function) Line \(#line): \(subString)")
        
        print("\(#file.split(separator: "/").last!) \(#function) Line \(#line): \(string.amk_substring(with: NSRange(location: 1, length: 4)))")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    // MARK: - Getters & Setters
    
    // MARK: - Data & Networking
    
    // MARK: - Layout Subviews
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    public override func updateViewConstraints() {
        // code...
        super.updateViewConstraints()
    }
    
    // MARK: - Action Methods
    
    // MARK: - Notifications
    
    // MARK: - KVO
    
    // MARK: - Protocols
    
    // MARK: - Helper Methods
    
}

// MARK: -
// MARK: -

extension String {
    
    public func amk_substring(with range: NSRange) -> String {
//        return NSString(string: self).substring(with: range)
        
        let startIndex = self.index(self.startIndex, offsetBy: range.location)
        let endIndex = self.index(self.startIndex, offsetBy: range.location + range.length)
        let subString = self[startIndex..<endIndex]
        return String(subString)
    }
    
}
