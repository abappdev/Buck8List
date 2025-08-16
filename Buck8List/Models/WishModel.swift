//
//  WishModel.swift
//  Buck8List
//
//  Created by Abhishek Bhalerao on 16/08/25.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    var isDone: Bool = false
    init(title: String,isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}
