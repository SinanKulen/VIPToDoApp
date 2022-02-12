//
//  CreateTodoViewController.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import UIKit

protocol CreateTodoDisplayLogic : NSObject
{
    func displayCreateTodo(viewModel: CreateTask.CreateTask.ViewModel)
}


class CreateTodoViewController: UIViewController, CreateTodoDisplayLogic {

    var interactor : CreateTodoBusinessLogic?
    var router : (CreateTodoRoutingLogic & CreateTodoDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        let viewController = self
        let interactor = CreateTodoInteractor()
        let presenter = CreateTodoPresenter()
        let router = CreateTodoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if let scene = segue.identifier
//        {
//            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
//            if let router = router, router.responds(to: selector)
//            {
//                router.perform(selector, with: segue)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    @IBOutlet var tfDate: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDetail: UITextField!
    
    func createDatePicker()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        tfDate.inputAccessoryView = toolbar
        tfDate.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func doneButtonClicked()
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        tfDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let title = tfTitle.text
        let detail = tfDetail.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateStr : Date?

        if let dateString = tfDate.text
        {
            dateStr = dateFormatter.date(from: dateString)
        }
        
   
        
        if tfTitle.text != ""
        {
            let request = CreateTask.CreateTask.Request(taskField: CreateTask.TaskField(title: title!, detail: detail!, date: dateStr!))
            interactor?.createTask(request: request)
        }
        else
        {
            alert(titleText: "Hata", messageText: "Veriler kaydedilemedi.")
        }
    }
    
    func displayCreateTodo(viewModel: CreateTask.CreateTask.ViewModel)
    {
        guard let isSuccess = viewModel.isSuccess else {
            alert(titleText: "Hata", messageText: "Veriler yüklenemedi.")
            return
        }
        
        if isSuccess {
            router?.routeTodoList()
        }
        else
        {
            alert(titleText: "Hata", messageText: "Liste ekranına ulaşılamıyor.")
        }
    }
    
    func alert(titleText: String, messageText: String)
    {
        let ac = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}
