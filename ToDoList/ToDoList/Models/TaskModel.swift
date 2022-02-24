//
//  TaskModel.swift
//  ToDoList
//
//  Created by Suhyoung Eo on 2022/01/15.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct TaskModel {
    let title: String
    let priority: Priority
}
