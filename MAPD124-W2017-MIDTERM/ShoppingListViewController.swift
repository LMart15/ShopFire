//
//  ShoppingListViewController.swift
//  MAPD124-W2017-MIDTERM
//
//  Created by Lawrence Martin on 2017-02-21.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ShoppingListViewController: UIViewController {
    
    var dbRef:FIRDatabaseReference!
    var shoppingList = [ShoppingItem]()
    
    let shoppingItem1 = ShoppingItem(itemName: "Milk", itemQuantity: 1)
    let shoppingItem2 = ShoppingItem(itemName: "Cookies", itemQuantity: 2)
    let shoppingItem3 = ShoppingItem(itemName: "Water", itemQuantity: 3)
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("Shopping List")
        self.startObservingDB()
        
        let shopRef = self.dbRef.childByAutoId()
        shopRef.setValue(shoppingItem3.toDictionary())
        
    }
    
    
    ///observe DB function to see changes in location value
    func startObservingDB() {
        
        dbRef.observe(.value, with: { (snapshot:FIRDataSnapshot) in
            var shopList = [ShoppingItem]()
            
            for shoppingItem in snapshot.children{
                let shoppingListObject = ShoppingItem(snapshot: shoppingItem as! FIRDataSnapshot)
                shopList.append(shoppingListObject)
            }
            
            //set data
            self.shoppingList = shopList
            //self.tableView.reloadData()
            
        }) {(error:Error) in
            print(error)
        }
        
    }


}
