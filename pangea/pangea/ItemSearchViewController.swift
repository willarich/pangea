//
//  ItemSearchViewController.swift
//  pangea
//
//  Created by Jesse Rittner on 4/13/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

import UIKit

class ItemSearchViewController: UITableViewController, UISearchResultsUpdating
{
    var searchController: UISearchController?
    
    let itemList = [ItemList(category:"Chocolate", name:"chocolate Bar", price: 1234),
    ItemList(category:"Chocolate", name:"chocolate Chip", price: 1234),
    ItemList(category:"Chocolate", name:"dark chocolate", price: 1234),
    ItemList(category:"Hard", name:"lollipop", price: 1234),
    ItemList(category:"Hard", name:"candy cane", price: 1234),
    ItemList(category:"Hard", name:"jaw breaker", price: 1234),
    ItemList(category:"Other", name:"caramel", price: 1234),
    ItemList(category:"Other", name:"sour chew", price: 1234),
    ItemList(category:"Other", name:"gummi bear", price: 1234)]
    
    var filteredList : [ItemList] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        self.title = "Item Search"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController!.searchResultsUpdater = self
        self.searchController!.hidesNavigationBarDuringPresentation = true
        self.searchController!.dimsBackgroundDuringPresentation = false
        self.searchController!.searchBar.searchBarStyle = .Minimal
        self.searchController!.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.searchController!.searchBar
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "itemDetail")
        {
            let itemDetailViewController = segue.destinationViewController as UIViewController
            let selectedCell = sender as UITableViewCell
            itemDetailViewController.title = selectedCell.textLabel?.text
        }
    }
    
    // MARK:- UITableViewDataSource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        var item : ItemList
        
        if self.searchController!.active
        {
            item = self.filteredList[indexPath.row]
        }
        else
        {
            item = self.itemList[indexPath.row]
        }
        
        cell.textLabel!.text = item.name
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.searchController!.active)
        {
            return self.filteredList.count
        }
        else
        {
            return self.itemList.count
        }
    }
}


// MARK:- UISearchResultsUpdating

extension ItemSearchViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if (searchController.searchBar.text.isEmpty)
        {
            self.filteredList = self.itemList
        }
        else
        {
            let searchPredicate =
            {
                (item: ItemList) -> Bool in
                item.name.rangeOfString(searchController.searchBar.text, options: .CaseInsensitiveSearch) != nil
            }
            self.filteredList = self.itemList.filter(searchPredicate)
        }
        self.tableView.reloadData()
    }
}