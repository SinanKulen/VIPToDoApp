//
//  CreateTodoPresenter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol CreateTodoPresentationLogic
{
    func presentCreateTodo(response: CreateTask.CreateTask.Response)
}

class CreateTodoPresenter : CreateTodoPresentationLogic
{
    weak var viewController : CreateTodoDisplayLogic?
    
    func presentCreateTodo(response: CreateTask.CreateTask.Response)
    {
        let viewModel = CreateTask.CreateTask.ViewModel(isSuccess: response.isSuccess)
        viewController?.displayCreateTodo(viewModel: viewModel)
    }
}
