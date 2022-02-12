//
//  TodoDetailPresenter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol TodoDetailPresentationLogic
{
    func presentTask(response: TaskDetail.FetchTask.Response)
}

class TodoDetailPresenter: TodoDetailPresentationLogic
{
    weak var viewController : TodoDetailDisplayLogic?
    
    func presentTask(response: TaskDetail.FetchTask.Response)
    {
        let viewModel = TaskDetail.FetchTask.ViewModel(title: response.task.title ?? "", detail: response.task.detail ?? "", date: response.task.date)
        viewController?.displayTask(viewModel: viewModel)
    }
}
