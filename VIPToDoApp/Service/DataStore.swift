//
//  DataStore.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import CoreData

protocol DataStoreProtocol
{
    func fetchTasks(completionHandler: @escaping (() throws -> [Task]) -> Void)
    func fetchTask(id: Int, completionHandler: @escaping (() throws -> Task?) -> Void)
    func createTask(title: String, detail: String, date: Date ,completionHandler: @escaping (() throws -> Bool?) -> Void)
}

class DataStore : DataStoreProtocol
{
    func fetchTasks(completionHandler: @escaping (() throws -> [Task]) -> Void)
    {
        let tasks = CoreDataManager.shared.fetchTasks(ascending: true)
        completionHandler
        {
            return tasks
        }
    }

    func fetchTask(id: Int, completionHandler: @escaping (() throws -> Task?) -> Void)
    {
        let task = CoreDataManager.shared.fetchTask(id: Int64(id))
        completionHandler
        {
            return task
        }
    }

    func createTask(title: String, detail: String, date: Date ,completionHandler: @escaping (() throws -> Bool?) -> Void)
    {
        CoreDataManager.shared.saveTask(title: title, detail: detail, date: date) { onSuccess in
            completionHandler
            {
                return onSuccess
            }
        }
    }
}


