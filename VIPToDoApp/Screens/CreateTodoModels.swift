//
//  CreateTodoModels.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

enum CreateTask
{
    struct TaskField
    {
        var title: String
        var detail: String
        var date: Date
    }

    // MARK: Use cases
    enum CreateTask
    {
        struct Request
        {
            var taskField: TaskField
        }
        struct Response
        {
            var isSuccess: Bool?
        }
        struct ViewModel
        {
            var isSuccess: Bool?
        }
    }
}
