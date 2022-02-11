//
//  TodoListRouter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import UIKit

@objc protocol TodoListRoutingLogic
{
    func routeToCreateTodo(segue: UIStoryboardSegue?)
}

protocol TodoListDataPassing
{
    var dataStore: TodoListDataStore? { get set }
}

class TodoListRouter: NSObject, TodoListDataPassing,TodoListRoutingLogic
{
    weak var viewController : TodoListViewController?
    var dataStore: TodoListDataStore?
    
    func routeToCreateTodo(segue: UIStoryboardSegue?)
    {
        if segue == nil
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "CreateTodoViewController") as! CreateTodoViewController
            navigateToCreateTodo(source: viewController!, destination: destinationVC)
            
        }
    }
    
    func navigateToCreateTodo(source: TodoListViewController, destination: CreateTodoViewController)
    {
        source.show(destination, sender: nil)
    }
}
