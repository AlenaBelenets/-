//
//  ViewController.swift
//  Заметки
//
//  Created by Alena Belenets on 03.01.2023.
//

import UIKit


class TaskListViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!

    private var taskList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        taskList = StorageManager.shared.fetchTask()

    }



    @IBAction func addNewTask(_ sender: Any) {
        showAlert(withTitle: "Новая задача", andMessage: "Что вы хотите сделать?")
    }

    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return}
            self.save(task)
        }
        let cancelAction = UIAlertAction(title: "Закрыть", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Новая задача"
        }

        present(alert, animated: true)
    }

    private func showEditAlert(_ with: Task) {
        let alert = UIAlertController(title: "Редактор задачи", message: "Внести изменение в текущую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return}
            self.save(task)
        }
        let cancelAction = UIAlertAction(title: "Закрыть", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = taskList.
        }

        present(alert, animated: true)

    }

    private func save(_ taskName: String) {
        taskList.append(taskName)

        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(
            at: [cellIndex],
            with: .automatic
        )

            StorageManager.shared.save(task: taskName)

        }

}


extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task
        cell.contentConfiguration = content

        return cell

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deleteTask(at: indexPath.row)
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = taskList[indexPath.row]

        let editAction = UIContextualAction(style: .normal, title: "изменить") { [unowned self] _, _, isDone in
            showEditAlert(with: ) {
                tableView.reloadRows(at: [indexPath], with: .automatic)

            }
        }

        return UISwipeActionsConfiguration(actions: [editAction])
    }


}


