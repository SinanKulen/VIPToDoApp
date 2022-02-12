//
//  TodoListRouter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import UIKit

protocol TodoListRoutingLogic
{
    func routeCreateTodo()
    func routeDetailTodo(index: Int)
}

protocol TodoListDataPassing
{
    var dataStore: TodoListDataStore? { get set }
}

final class TodoListRouter: NSObject, TodoListDataPassing,TodoListRoutingLogic
{
    weak var viewController : TodoListViewController?
    var dataStore: TodoListDataStore?
    
    
    func routeCreateTodo()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "CreateTodoViewController") as! CreateTodoViewController
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeDetailTodo(index: Int)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as! TodoDetailViewController
        destinationVC.router?.dataStore?.task = dataStore!.tasks![index]
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
