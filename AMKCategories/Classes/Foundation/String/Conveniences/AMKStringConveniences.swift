//
//  String+AMKConveniences.swift
//  AFNetworking
//
//  Created by Meng Xinxin on 2023/7/18.
//

import Foundation

extension String {
    
    public func amk_substring(with range: NSRange) -> String {
        return NSString(string: self).substring(with: range)
    }
    
}
