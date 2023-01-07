//
//  StorageManager.swift
//  Заметки
//
//  Created by Alena Belenets on 03.01.2023.
//

import Foundation

class StorageManager {

    static let shared = StorageManager()

    private let defaults = UserDefaults.standard
    private let taskKey = "taskKey"

    private init() {}

    func save(task: String) {
        var tasks = fetchTask()
        tasks.append(task)

        defaults.set(tasks, forKey: taskKey)
    }

    func fetchTask() -> [String] {
        if let tasks = defaults.value(forKey: taskKey) as? [String] {
            return tasks
        }

        return []

    }

    func deleteTask(at index: Int) {
        var tasks = fetchTask()
        tasks.remove(at: index)
        defaults.set(tasks, forKey: taskKey)
    }
    
    func edit(_ task: Task, newValue: String)  {
        let newValue = task.name
        
        defaults.set(newValue, forKey: taskKey)
    }

}
