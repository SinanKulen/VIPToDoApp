//
//  TodoDetailModels.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

enum TaskDetail
{
    enum FetchTask
    {
        struct Request
        {
            
        }
        struct Response
        {
            var task : Task
        }
        struct ViewModel
        {
            var title : String
            var detail : String
            var date : Date
        }
    }
}
