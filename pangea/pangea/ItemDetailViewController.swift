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
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        let nibContents = NSBundle.mainBundle().loadNibNamed("ItemDetailView", owner: self, options: nil)
        self.view = nibContents[0] as! UIView
        self.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}