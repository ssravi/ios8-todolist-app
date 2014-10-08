//
//  SecondViewController.swift
//  todolist
//
//  Created by Ravi Teja Vadrevu on 9/30/14.
//  Copyright (c) 2014 Ravi Teja Vadrevu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    

    @IBOutlet weak var todoItem: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(sender: AnyObject) {
        todoItems.append(todoItem.text)
        let fixedtoDoItems = todoItems
        NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

    

}

