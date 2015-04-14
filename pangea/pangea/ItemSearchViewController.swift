//
//  ItemSearchViewController.swift
//  pangea
//
//  Created by Jesse Rittner on 4/13/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

import UIKit

class ItemSearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController?
    let categories = ["All", "Chocolate", "Hard", "Other"]
    
    let itemList = [ItemList(category:"Chocolate", name:"Chocolate Bar", price: 1234),
    ItemList(category:"Chocolate", name:"Chocolate Chip", price: 1234),
    ItemList(category:"Chocolate", name:"Dark Chocolate", price: 1234),
    ItemList(category:"Hard", name:"Lollipop", price: 1234),
    ItemList(category:"Hard", name:"Candy Cane", price: 1234),
    ItemList(category:"Hard", name:"Jaw Breaker", price: 1234),
    ItemList(category:"Other", name:"Caramel", price: 1234),
    ItemList(category:"Other", name:"Sour Chew", price: 1234),
    ItemList(category:"Other", name:"Gummi Bear", price: 1234)]
    
    var filteredList : [ItemList] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.definesPresentationContext = true
        
        self.title = "Item Search"
        self.tableView.dataSource = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController!.searchResultsUpdater = self
        self.searchController!.hidesNavigationBarDuringPresentation = true
        self.searchController!.dimsBackgroundDuringPresentation = false
        self.searchController!.searchBar.searchBarStyle = .Default
        self.searchController!.searchBar.sizeToFit()
        self.searchController!.searchBar.scopeButtonTitles = self.categories
        self.searchController!.searchBar.delegate = self
        self.tableView.tableHeaderView = self.searchController!.searchBar
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow()
        {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: animated)
        }
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
}

// MARK:- UITableViewDataSource

extension ItemSearchViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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

// MARK:- UISearchBarDelegate

extension ItemSearchViewController: UISearchBarDelegate
{
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        self.updateSearchResultsForSearchController(self.searchController!)
    }
}

// MARK:- UISearchResultsUpdating

extension ItemSearchViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let categoryPredicate = getCategoryPredicate(searchController)
        let searchPredicate = getSearchPredicate(searchController)

        self.filteredList = self.itemList.filter(Bool.all(categoryPredicate, searchPredicate))
        self.tableView.reloadData()
    }
    
    func getCategoryPredicate(searchController: UISearchController) -> ItemList -> Bool
    {
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        let selectedCategory = self.categories[selectedIndex]
        if (selectedCategory == "All")
        {
            return { (_: ItemList) in true }
        }
        else
        {
            return { (item: ItemList) in item.category == selectedCategory }
        }
    }
    
    func getSearchPredicate(searchController: UISearchController) -> ItemList -> Bool
    {
        if (searchController.searchBar.text.isEmpty)
        {
            return { (_: ItemList) in true }
        }
        else
        {
            return { (item: ItemList) in item.name.rangeOfString(searchController.searchBar.text, options: .CaseInsensitiveSearch) != nil }
        }
    }
}