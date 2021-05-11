//
//  EndPoint.swift
//  Shop
//
//  Created by Harpreet on 10/05/21.
//

import Foundation

enum EndPoint {
    case categories
}

//MARK:- END POINT DETAILS
extension EndPoint {
    var baseUrl: String {
        "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com/api/products/"
    }
}
