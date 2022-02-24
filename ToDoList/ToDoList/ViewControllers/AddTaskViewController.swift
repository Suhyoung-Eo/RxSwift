//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Suhyoung Eo on 2022/01/15.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    private let taskSubject = PublishSubject<TaskModel>()
    
    var taskSubjectObservable: Observable<TaskModel> {
        return taskSubject.asObservable()
    }

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedSaveButton(_ sender: Any) {
        
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex), let title = textField.text else { return }
        
        let task = TaskModel(title: title, priority: priority)
        taskSubject.onNext(task)
        
        dismiss(animated: true, completion: nil)
    }
}
