//
//  FirstViewController.swift
//  todolist
//
//  Created by Ravi Teja Vadrevu on 9/30/14.
//  Copyright (c) 2014 Ravi Teja Vadrevu. All rights reserved.
//

import UIKit

var todoItems:[String] = []

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var tasksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "Cell")
        let todoText = todoItems[indexPath.row]
        cell.textLabel?.text = todoText
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        var maximumLabelSize:CGSize = CGSizeMake(310, 9999);
        var expectSize:CGSize = (cell.textLabel?.sizeThatFits(maximumLabelSize))!
        var height:CGFloat = expectSize.height
        return height
    }
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todoItems.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "Cell")
        let todoText = todoItems[indexPath.row]
        cell.textLabel?.text = todoText
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            todoItems.removeAtIndex(indexPath.row)
            let fixedtoDoItems = todoItems
            NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
            NSUserDefaults.standardUserDefaults().synchronize()
            tasksTable.reloadData()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems"){
            todoItems = []
            for var i=0; i < storedtoDoItems.count; i++ {
                todoItems.append(storedtoDoItems[i] as NSString)
            }
            
        }
        
        tasksTable.reloadData()
    }


}

