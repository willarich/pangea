//
//  CategoryViewController.swift
//  pangea
//
//  Created by Will Richardson on 4/7/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func categoryButton_Clicked(sender: AnyObject?)
    {
        self.performSegueWithIdentifier("categoryDetail", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "categoryDetail")
        {
            let clickedButton = sender as! UIButton
            let category = clickedButton.titleLabel!.text!
            let destinationViewController = segue.destinationViewController as! ItemSearchViewController
            let categoryIndex = find(destinationViewController.categories, category)!
            destinationViewController.category = category
        }
    }
}
