/*:
 
 - File itemName:
 ShoppingItem.swift
 
 - Author:
 Lawrence Martin
 
 - App itemName:
 ShopFire
 
 - Student ID:
 300782358
 
 - File Description:
 Shopping Item model
 
 - Date
 Feb 21, 2017
 
 */


import Foundation
import FirebaseDatabase


class ShoppingItem: NSObject {
    
    let key:String!
    let itemRef:FIRDatabaseReference?
    
    var itemName: String?
    var itemQuantity:String?
     
    init(key:String = "", itemName:String, itemQuantity: String) {
        
        self.itemRef = nil
        self.key = key
        
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        
    }
    
    init(snapshot:FIRDataSnapshot) {
        
        key = snapshot.key
        itemRef = snapshot.ref
        let snapshotValue = snapshot.value as? NSDictionary
        
        itemName = snapshotValue?["itemName"] as? String
        itemQuantity = snapshotValue?["itemQuantity"] as? String
    }
    
    ///Convert all fields to string for easy storage in Firebase
    func toDictionary() -> [String:String] {
        
        return ["itemName":itemName!, "itemQuantity": itemQuantity!]
    }
    
}
