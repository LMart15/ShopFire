/*:
 
 - File Name:
 TaskCell.swift
 
 - Author:
 Lawrence Martin
 
 - App Name:
 TaskFire
 
 - Student ID:
 300782358
 
 - File Description:
 Custom cell for tasks
 
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
