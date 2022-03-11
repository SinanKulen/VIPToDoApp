//
//  TodoListInteractor.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol TodoListBusinessLogic
{
    func fetchTasks(request: TaskList.FetchTasks.Request)
}

protocol TodoListDataStore
{
    var tasks : [Task]? { get set }
}

class TodoListInteractor: TodoListBusinessLogic, TodoListDataStore
{
    var presenter : TodoListPresentationLogic?
    var dataWorker = DataWorker(dataStore: DataStore())
    var tasks : [Task]?
    
    func fetchTasks(request: TaskList.FetchTasks.Request)
    {
        dataWorker.fetchTasks { tasks in
            self.tasks = tasks
            let response = TaskList.FetchTasks.Response(tasks: tasks)
            self.presenter?.presentTasks(response: response)
        }
    }
}
