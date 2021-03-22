//
//  MasterViewController.swift
//  ApplePaySwag
//
//  Created by Erik.Kerber on 10/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class SwagListViewController: UITableViewController {

    var swagList = [
        Swag(   image: UIImage(named: "iGT"),
                title: "iOS Games by Tutorials",
                price: 54.00,
                type: SwagType.Electronic,
                description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),
        
        Swag(   image: UIImage(named: "iOSApprentice"),
                title: "iOS Apprentice",
                price: 54.00, type:
                SwagType.Electronic,
                description: "The iOS Apprentice is a series of epic-length tutorials for beginners where you’ll learn how to build 4 complete apps from scratch."),
        
        Swag(   image: UIImage(named: "RW_button_pack"),
                title: "Button Pack",
                price: 9.99,
                type: SwagType.Delivered,
                description: "A pack of Ray Wenderlich buttons!."),

        Swag(   image: UIImage(named: "RW-Sticker"),
                title: "Sticker",
                price: 2.99,
                type: SwagType.Delivered,
                description: "A really cool sticker!"),
        
        Swag(   image: UIImage(named: "rw-t-shirt"),
                title: "T-Shirt",
                price: 14.99,
                type: SwagType.Delivered,
                description: "Sport a stylish black t-shirt with a colorful mosaic iPhone design!"),
    ]

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = swagList[indexPath.row]
                (segue.destination as! BuySwagViewController).swag = object
            }
        }
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swagList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! SwagCell

        let object = swagList[indexPath.row]
        cell.titleLabel.text = object.title
        cell.priceLabel.text = "$" + object.priceString
        cell.swagImage.image = object.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

