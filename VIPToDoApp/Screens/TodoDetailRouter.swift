//
//  TodoDetailRouter.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation

protocol TodoDetailRoutingLogic : AnyObject
{
    
}

protocol TodoDetailDataPassing : AnyObject
{
    var dataStore : TodoDetailDataStore? { get set }
}

final class TodoDetailRouter : TodoDetailRoutingLogic, TodoDetailDataPassing
{
    weak var viewController : TodoDetailViewController?
    var dataStore : TodoDetailDataStore?
}
