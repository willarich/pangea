//
//  ItemTableViewController.swift
//  pangea
//
//  Created by Will Richardson on 4/6/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

import UIKit

class ItemTableViewController : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    var itemList = [ItemList]()
    var filteredItemList = [ItemList]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sample Data for candyArray
        self.itemList = [ItemList(category:"Chocolate", name:"chocolate Bar", price: 1234),
            ItemList(category:"Chocolate", name:"chocolate Chip", price: 1234),
            ItemList(category:"Chocolate", name:"dark chocolate", price: 1234),
            ItemList(category:"Hard", name:"lollipop", price: 1234),
            ItemList(category:"Hard", name:"candy cane", price: 1234),
            ItemList(category:"Hard", name:"jaw breaker", price: 1234),
            ItemList(category:"Other", name:"caramel", price: 1234),
            ItemList(category:"Other", name:"sour chew", price: 1234),
            ItemList(category:"Other", name:"gummi bear", price: 1234)]
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        // Filter the array using the filter method
        
        self.filteredItemList = self.itemList.filter({ (items: ItemList)-> Bool in
            let stringMatch = items.name.rangeOfString(searchText)
            return stringMatch != nil ? true : false
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredItemList.count
        } else {
            return self.itemList.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var item : ItemList
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            item = filteredItemList[indexPath.row]
        } else {
            item = itemList[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel!.text = item.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("itemDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "itemDetail" {
            let itemDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredItemList[indexPath.row].name
                itemDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let destinationTitle = self.itemList[indexPath.row].name
                itemDetailViewController.title = destinationTitle
            }
        }
    }
}
