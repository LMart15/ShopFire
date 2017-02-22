/*:
 
 - File itemName:
 ShoppingItemCell.swift
 
 - Author:
 Lawrence Martin
 
 - App itemName:
 ShopFire
 
 - Student ID:
 300782358
 
 - File Description:
 Shopping Item Cell model
 
 - Date
 Feb 21, 2017
 
 */


import UIKit

class ShoppingItemCell: UITableViewCell {
    
    // Custom Task cell consists of Name, Note labels and Completed status switch
    @IBOutlet weak var itemName_lbl: UILabel!
    @IBOutlet weak var itemQuantity_lbl: UILabel!
 
    
    ///  Configure or instantiate custom cell
    func configureCell(itemName: String, itemQuantity: String){
        
        itemName_lbl.text = itemName
        itemQuantity_lbl.text = itemQuantity
        
    }
    
    
}
