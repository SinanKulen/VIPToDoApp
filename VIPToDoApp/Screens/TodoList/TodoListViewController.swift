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

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoListDisplayLogic, UISearchBarDelegate {

    var interactor : TodoListBusinessLogic?
    var router : (TodoListRoutingLogic & TodoListDataPassing)?
    
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
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        router?.routeCreateTodo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTasks()
        searchBar.enablesReturnKeyAutomatically = false
        tableView.keyboardDismissMode = .onDrag
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
    
    @IBOutlet var searchBar: UISearchBar!
    var filteredData = [String]()
    var isSearching = false
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""
        {
            isSearching = false
            tableView.reloadData()
        }
        else
        {
            isSearching = true
            var displayArray = [String]()
            for display in displayedTasks
            {
                displayArray.append(display.title)
            }
            filteredData = displayArray.filter({ $0.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
    
    @IBOutlet var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching
        {
            return filteredData.count
        } else {
            return displayedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        if isSearching
        {
            cell.lblTitle.text = filteredData[indexPath.row]
        } else {
            let displayTask = displayedTasks[indexPath.row]
            cell.bindData(title: displayTask.title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeDetailTodo(index: indexPath.row)
    }
}
