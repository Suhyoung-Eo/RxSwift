//
//  ViewController.swift
//  ToDoList
//
//  Created by Suhyoung Eo on 2022/01/15.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
//    private var tasks = Variable<[TaskModel]>([]) // will deprecate
    private let tasks = BehaviorRelay<[TaskModel]>(value: [])
    private var filteredTasks = [TaskModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    @IBAction func prioritySegmentedControl(_ sender: UISegmentedControl) {
        
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navigationVC = segue.destination as? UINavigationController,
              let destinationVC = navigationVC.viewControllers.first as? AddTaskViewController else {
                  fatalError("Could not find ViewController")
              }
        
        destinationVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] taskModel in
                
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var task = self.tasks.value
                task.append(taskModel)
                self.tasks.accept(task)
                self.filterTask(by: priority)
                
            }).disposed(by: disposeBag)
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTask(by priority: Priority?) {
        
        if priority != nil {
            tasks.map { tasks in
                return tasks.filter { $0.priority == priority }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
            }).disposed(by: disposeBag)
        } else {
            filteredTasks = tasks.value
        }
        updateTableView()
    }
}

//MARK: - TableView datasource

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        
        return cell
    }
    
}
