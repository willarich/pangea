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


    @IBAction func All()
    {
        self.performSegueWithIdentifier("categoryDetail", sender: "All")
    }

    @IBAction func Other()
    {
        self.performSegueWithIdentifier("categoryDetail", sender: "Other")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let categoryType = sender as String
        let destinationViewController = segue.destinationViewController as ItemSearchViewController
        if (segue.identifier == "categoryDetail")
        {
            if (categoryType == "All")
            {
                let hi = 1
                println("All clicked")
            }
            else
            {
                let hi = 2
            }
        }
    }
}
