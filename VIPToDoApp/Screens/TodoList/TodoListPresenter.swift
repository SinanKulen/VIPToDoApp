//
//  TodoListPresenter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol TodoListPresentationLogic
{
    func presentTasks(response: TaskList.FetchTasks.Response)
}

class TodoListPresenter: TodoListPresentationLogic
{
    weak var viewController : TodoListDisplayLogic?
    
    func presentTasks(response: TaskList.FetchTasks.Response)
    {
        var displayedTaks : [TaskList.FetchTasks.ViewModel.DisplayedTask] = []
        
        for task in response.tasks
        {
            let displayedTask = TaskList.FetchTasks.ViewModel.DisplayedTask(id: Int(task.id), title: task.title!)
            displayedTaks.append(displayedTask)
        }
        
        let viewModel = TaskList.FetchTasks.ViewModel(displayedTasks: displayedTaks)
        viewController?.displayTaskList(viewModel: viewModel)
    }
}
