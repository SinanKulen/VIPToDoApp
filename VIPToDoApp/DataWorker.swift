//
//  DataWorker.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import CoreData

class DataWorker
{
    var dataStore : DataStoreProtocol
    
    init(dataStore: DataStoreProtocol)
    {
        self.dataStore = dataStore
    }
    
    func fetchTasks(completionHandler: @escaping ([Task]) -> Void)
    {
        dataStore.fetchTasks { (tasks: () throws -> [Task]) -> Void in
            do
            {
                let tasks = try tasks()
                DispatchQueue.main.async {
                    completionHandler(tasks)
                }
            }
            catch
            {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchTask(id: Int, completionHandler: @escaping (Task?) -> Void)
    {
        dataStore.fetchTask(id: id) { (task: () throws -> Task?) -> Void in
            do
            {
                let task = try task()
                DispatchQueue.main.async {
                    completionHandler(task)
                }
            }
            catch
            {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
    
    func createTask(title: String, detail: String, date: Date, completionHandler: @escaping (Bool?) -> Void)
    {
        dataStore.createTask(title: title, detail: detail, date: date) { (success: () throws -> Bool?) -> Void in
            do
            {
                let success = try success()
                DispatchQueue.main.async {
                    completionHandler(success)
                }
            }
            catch
            {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
}
