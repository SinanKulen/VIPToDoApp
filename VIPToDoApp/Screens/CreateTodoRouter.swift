//
//  CreateTodoRouter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import UIKit

protocol CreateTodoRoutingLogic
{
    func routeTodoList()
}

protocol CreateTodoDataPassing
{
    var dataStore : CreateTodoDataStore? { get }
}

class CreateTodoRouter : NSObject, CreateTodoRoutingLogic, CreateTodoDataPassing
{
     weak var viewController : CreateTodoViewController?
     var dataStore: CreateTodoDataStore?
     
    func routeTodoList()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
        destinationVC.router?.dataStore = dataStore as? TodoListDataStore
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
 }
