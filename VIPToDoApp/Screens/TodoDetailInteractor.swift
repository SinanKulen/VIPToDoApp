//
//  TodoDetailInteractor.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol TodoDetailBusinessLogic
{
    func fetchTask(request: TaskDetail.FetchTask.Request)
}

protocol TodoDetailDataStore
{
    var id : Int? { get set }
    var task : Task? { get set }
}

class TodoDetailInteractor: TodoDetailDataStore, TodoDetailBusinessLogic
{
    var presenter : TodoDetailPresentationLogic?
    var dataWorker = DataWorker(dataStore: DataStore())
    
    var id : Int?
    var task : Task?
    
    func fetchTask(request: TaskDetail.FetchTask.Request)
    {
        if task != nil
        {
            dataWorker.fetchTask(id: task!.id) { task in
                self.task = task
                let response = TaskDetail.FetchTask.Response(task: task!)
                self.presenter?.presentTask(response: response)
            }
        }
    }
}
