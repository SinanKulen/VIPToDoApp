//
//  CreateTodoInteractor.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol CreateTodoBusinessLogic
{
    func createTask(request: CreateTask.CreateTask.Request)
}

protocol CreateTodoDataStore
{
    
}

class CreateTodoInteractor : CreateTodoBusinessLogic, CreateTodoDataStore
{
    var presenter : CreateTodoPresentationLogic?
    var dataWorker = DataWorker(dataStore: DataStore())
    
    func createTask(request: CreateTask.CreateTask.Request)
    {
        let title = request.taskField.title
        let detail = request.taskField.detail
        let date = request.taskField.date
        
        dataWorker.createTask(title: title, detail: detail, date: date) { (isSuccess:  Bool?) in
            let response = CreateTask.CreateTask.Response(isSuccess: isSuccess)
            self.presenter?.presentCreateTodo(response: response)
            
        }
    }
}
