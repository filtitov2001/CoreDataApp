//
//  Extension + UIAlertController.swift
//  CoreDataApp
//
//  Created by Felix Titov on 7/31/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation
import UIKit

extension UIAlertController {
    static func create(with title: String) -> UIAlertController {
        UIAlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
    }
    
    func action(task: Task?, completion: @escaping (String) -> Void) {
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let newValue = self.textFields?.first?.text else { return }
                guard !newValue.isEmpty else { return }
                completion(newValue)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            
            addAction(saveAction)
            addAction(cancelAction)
            addTextField { textField in
                textField.placeholder = "Task"
                textField.text = task?.title
            }
        }
}
