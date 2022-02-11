//
//  CreateTodoRouter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import UIKit

@objc protocol CreateTodoRoutingLogic
{
    func routeTodoList(segue: UIStoryboardSegue?)
}

protocol CreateTodoDataPassing
{
    var dataStore : CreateTodoDataStore? { get }
}

class CreateTodoRouter : NSObject, CreateTodoRoutingLogic, CreateTodoDataPassing
{
     weak var viewController : CreateTodoViewController?
     var dataStore: CreateTodoDataStore?
     
     func routeTodoList(segue: UIStoryboardSegue?)
     {
         if let segue = segue
         {
             let destinationVC = segue.destination as! TodoListViewController
             var destinationDS = destinationVC.router!.dataStore!
             passDataToTodoList(source: dataStore!, destination: &destinationDS)
             navigateTodoList(source: viewController!, destination: destinationVC)
         }
         else
         {
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
             var destinationDS = destinationVC.router!.dataStore!
             passDataToTodoList(source: dataStore!, destination: &destinationDS)
             navigateTodoList(source: viewController!, destination: destinationVC)
             
         }
     }
     
     func navigateTodoList(source: CreateTodoViewController, destination: TodoListViewController)
     {
         source.navigationController?.popViewController(animated: true)
     }
    
    func passDataToTodoList(source: CreateTodoDataStore, destination: inout TodoListDataStore)
    {
        
    }
 }
