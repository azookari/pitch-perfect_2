//
//  FileName.swift
//  PerfectPichApp
//
//  Created by Omar Azookari on 4/5/15.
//  Copyright (c) 2015 Omar Azookari. All rights reserved.
//

import Foundation
class FileName: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    init(givenPath path:NSURL, givenTitle title: String){
        filePathUrl = path
        self.title = title
    }

}