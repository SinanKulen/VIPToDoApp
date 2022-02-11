//
//  TodoListViewController.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import UIKit

protocol TodoListDisplayLogic : NSObject
{
    func displayTaskList(viewModel: TaskList.FetchTasks.ViewModel)
}

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoListDisplayLogic {

    var interactor : TodoListBusinessLogic?
    var router : (NSObjectProtocol & TodoListRoutingLogic & TodoListDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        let viewController = self
        let interactor = TodoListInteractor()
        let presenter = TodoListPresenter()
        let router = TodoListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier
        {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector)
            {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTasks()
    }
    
    var displayedTasks: [TaskList.FetchTasks.ViewModel.DisplayedTask] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
 
    func fetchTasks()
    {
        let request = TaskList.FetchTasks.Request()
        interactor?.fetchTasks(request: request)
    }
    
    func displayTaskList(viewModel: TaskList.FetchTasks.ViewModel) {
        displayedTasks = viewModel.displayedTasks
    }
    
    @IBOutlet var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        let displayedTask = displayedTasks[indexPath.row]
        cell.bindData(title: displayedTask.title)
        return cell
    }
}
