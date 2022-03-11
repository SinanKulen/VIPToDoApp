//
//  TodoListModels.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

enum TaskList
{
    enum FetchTasks
    {
        struct Request
        {
            
        }
        struct Response
        {
            var tasks: [Task]
        }
        struct ViewModel
        {
            var displayedTasks : [DisplayedTask]
            
            struct DisplayedTask
            {
                
                var id : Int
                var title : String
            }
        }
    }
    
}
