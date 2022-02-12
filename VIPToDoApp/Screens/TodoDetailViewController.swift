//
//  TodoDetailViewController.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import UIKit

protocol TodoDetailDisplayLogic: NSObject
{
    func displayTask(viewModel: TaskDetail.FetchTask.ViewModel)
}

class TodoDetailViewController: UIViewController, TodoDetailDisplayLogic {

    var interactor : TodoDetailBusinessLogic?
    var router : (TodoDetailRoutingLogic & TodoDetailDataPassing)?
    
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
        let interactor = TodoDetailInteractor()
        let presenter = TodoDetailPresenter()
        let router = TodoDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTask()
    }
    
    @IBOutlet var tfDetail: UITextField!
    @IBOutlet var tfDate: UITextField!
    @IBOutlet var tfTitle: UITextField!
    
    func fetchTask()
    {
        let request = TaskDetail.FetchTask.Request()
        interactor?.fetchTask(request: request)
    }
    
    func displayTask(viewModel: TaskDetail.FetchTask.ViewModel)
    {
        tfTitle.text = viewModel.title
        tfDetail.text = viewModel.detail
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: viewModel.date)
        tfDate.text = dateString
    }
}
