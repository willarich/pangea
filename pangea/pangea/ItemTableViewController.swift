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


    /*
        Currently creates sample data then reloads the table. Update as functionality changes.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemList = [ItemList(category:"Chocolate", name:"chocolate Bar", price: 1234),
            ItemList(category:"Chocolate", name:"chocolate Chip", price: 1234),
            ItemList(category:"Chocolate", name:"dark chocolate", price: 1234),
            ItemList(category:"Hard", name:"lollipop", price: 1234),
            ItemList(category:"Hard", name:"candy cane", price: 1234),
            ItemList(category:"Hard", name:"jaw breaker", price: 1234),
            ItemList(category:"Other", name:"caramel", price: 1234),
            ItemList(category:"Other", name:"sour chew", price: 1234),
            ItemList(category:"Other", name:"gummi bear", price: 1234)]
        
        self.tableView.reloadData()
    }
    
    /*
        Returns true or false depending on whether the given item should be a
        part of the filtered item list after a search query is entered
    */
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredItemList = self.itemList.filter({ (items: ItemList)-> Bool in
            let stringMatch = items.name.rangeOfString(searchText)
            return stringMatch != nil ? true : false
        })
    }
    
    /*
        Updated the UI to show the filtered list of results -- ??
    */
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredItemList.count
        } else {
            return self.itemList.count
        }
    }

    /*
        Asks for reusable cells for the table view and creates a new one if none 
        are available. Checks to see if the full table is being displayed or 
        just the filtered item list. Then configures the cells.
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        var item : ItemList
            
        if tableView == self.searchDisplayController!.searchResultsTableView {
            item = filteredItemList[indexPath.row]
        }
        else {
            item = itemList[indexPath.row]
        }

        cell.textLabel!.text = item.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.performSegueWithIdentifier("itemDetail", sender: tableView)
        //self.navigationController?.setNavigationBarHidden(false, animated: false)

            }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "itemDetail" {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
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
