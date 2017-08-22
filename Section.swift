//
//  Section.swift
//  TableViewMix
//
//  Created by Umesh Chauhan on 22/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import Foundation

class items{
    var title : String
    var value : Int
    
    init(title : String, value: Int) {
        self.title = title
        self.value = value
    }
}

class sections {
    
    var headerTitle: String
    var sectionItem : [items]!
    
    init(headerTitle : String,sectionItem:[items]) {
        self.headerTitle = headerTitle
        self.sectionItem = sectionItem
    }
}
