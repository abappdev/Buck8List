//
//  AppTip.swift
//  Buck8List
//
//  Created by Abhishek Bhalerao on 16/08/25.
//

import Foundation
import TipKit

struct AppTip: Tip {
    var title: Text = Text("Add Item")
    var message: Text? = Text("Add new item in list and update them by swiping")
    var image: Image = Image(systemName: "info.circle")
}
