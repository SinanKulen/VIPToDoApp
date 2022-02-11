//
//  CoreDataManager.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager
{
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate : AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    func fetchTasks(ascending: Bool = false) -> [Task]
    {
        var models : [Task] = [Task]()
        
        if let context = context
        {
            let idSort : NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest : NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
            fetchRequest.sortDescriptors = [idSort]
            
            do
            {
                if let fetchResult = try context.fetch(fetchRequest) as? [Tasks]
                {
                    for item in fetchResult
                    {
                        let task = Task(id: Int(item.id), title: item.title, detail: item.detail, date: item.date!)
                        models.append(task)
                    }
                }
            }
            catch let error as NSError
            {
                print("Error - \(error)")
            }
        }
        return models
    }
    
    func fetchTask(id: Int64) -> Task?
    {
        var task : Task?
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results : [Tasks] = try context?.fetch(fetchRequest) as? [Tasks]
            {
                if results.count != 0
                {
                    let result = results[0]
                    task = Task(id: Int(result.id), title: result.title, detail: result.detail, date: result.date!)
                }
            }
        }
        catch let error as NSError
        {
            print("Error \(error)")
        }
        
        if task != nil
        {
            return task
        } else
        {
            return nil
        }
    }
    
    func saveTask(title: String, detail:String, date: Date, onSuccess: @escaping ((Bool) -> Void))
    {
        if let context = context, let entity : NSEntityDescription = NSEntityDescription.entity(forEntityName: "Tasks", in: context)
        {
            var lastId : Int = 0
            let fetchRequest : NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
            do
            {
                if let fetchResult: [Tasks] = try context.fetch(fetchRequest) as? [Tasks]
                {
                    if fetchResult.count != 0
                    {
                        lastId = Int(fetchResult[fetchResult.count-1].id) //MARK: Anlamadım Mantığını
                    } else
                    {
                        lastId = 0
                    }
                }
            }
            catch let error as NSError
            {
                print("Error \(error)")
            }
            
            if let task : Tasks = NSManagedObject(entity: entity, insertInto: context) as? Tasks
            {
                task.id = Int32(lastId + 1)
                task.title = title
                task.detail = detail
                task.date = date
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
}

extension CoreDataManager
{
    func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult>
    {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
    func contextSave(onSuccess: (Bool)->Void)
    {
        do
        {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError
        {
            print("Error \(error)")
            onSuccess(false)
        }
    }
}
