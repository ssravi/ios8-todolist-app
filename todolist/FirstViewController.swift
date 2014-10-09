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
    
    let reuseIdentifer = "identifier"
    lazy var sizingCell: TableViewCell? = {
        return TableViewCell.loadFromNib()
    }()

    @IBOutlet weak var tasksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tasksTable.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let todoText = todoItems[indexPath.row]
        var height: CGFloat = 0.0
        if let cell = sizingCell {
            height = cell.heightWith(todoText, width: tableView.frame.size.width)
        }
        // this should be cached
        println("height: \(height)")
        
        return height
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todoItems.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifer, forIndexPath: indexPath) as TableViewCell
        
        let todoText = todoItems[indexPath.row]
        cell.populateCell(todoText)
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

