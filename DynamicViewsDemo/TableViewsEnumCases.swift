//
//  TableViewsEnumCases.swift
//  DynamicViewsDemo
//
//  Created by Mohamed Korany on 7/22/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation
import UIKit
enum ViewsEnum : CaseIterable {
    
    case label , textField , Button , Switch , datePicker , checkBox
}


extension ViewsEnum {
    var dislayLabel : String {
        switch self {
            
        case .label:
            return "UILabel"
        case .textField:
            return "UITextField"
        case .Button:
            return "UIButton"
        case .Switch:
            return "UISwitch"
        case .datePicker:
            return "UIDatePicker"
        case .checkBox:
            return "UICheckBox"
        }
    }

}
