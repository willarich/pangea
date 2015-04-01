//
//  ItemDetailViewController.swift
//  pangea
//
//  Created by rayBucknell on 4/1/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController
{
    var itemImage : UIImage?
    var itemName : String?
    var itemDescription : String?
    var itemPrice : Int?
    
    private var itemImageView : UIImageView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.itemImageView!.image = self.itemImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}