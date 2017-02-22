/*:
 
 - File itemName:
 ShoppingListViewController.swift
 
 - Author:
 Lawrence Martin
 
 - App itemName:
 ShopFire
 
 - Student ID:
 300782358
 
 - File Description:
 Shopping List View Controller
 
 - Date
 Feb 21, 2017
 
 */

import UIKit
import FirebaseDatabase

class ShoppingListViewController: UIViewController, UITableViewDataSource {
    
    var dbRef:FIRDatabaseReference!
    var shoppingList = [ShoppingItem]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemQuantity_lbl: UILabel!
    
    @IBOutlet weak var newItemName_tv: UITextField!
    @IBOutlet weak var newItemQuantity_tv: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("Shopping List")
        self.startObservingDB()
        
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
            self.tableView.reloadData()
            
        }) {(error:Error) in
            print(error)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: "shoppingItemCellIdentifier", for: indexPath) as? ShoppingItemCell{
            
            let iQuantity = shoppingList[indexPath.row].itemQuantity!
            
            cell.configureCell(itemName: shoppingList[indexPath.row].itemName!,
                               itemQuantity: iQuantity)
            
            return cell
        }
        else {
            return ShoppingItemCell()
        }
    }

    ///Adjust Quantity value with stepper
    @IBAction func adjustQuantity(_ sender: UIStepper) {
    
        var selectedItem:ShoppingItem
        var iQuantity:Int
        
        let point = CGPoint(x: 0, y: 0)
        let buttonPosition = sender.convert(point, to: self.tableView)
        var indexPath = self.tableView.indexPathForRow(at: buttonPosition)!
        
        selectedItem = self.shoppingList[indexPath.row]
        iQuantity = Int(selectedItem.itemQuantity!)!
        
        dbRef.child(selectedItem.key).updateChildValues(["itemQuantity" : String(iQuantity)])
        
    }

    ///Add item to list and storage
    @IBAction func addItem(_ sender: UIButton) {
        
        if newItemName_tv.text!.isEmpty || newItemQuantity_tv.text!.isEmpty {
            
            showAlert()
            
        }else{
            
            let shoppingItem = ShoppingItem(itemName: newItemName_tv.text!, itemQuantity: newItemQuantity_tv.text!)
            
            let shoppingItemRef = self.dbRef.childByAutoId()
            shoppingItemRef.setValue(shoppingItem.toDictionary())
            
        }
        
    }
    
    @IBAction func cancelAdd(_ sender: UIBarButtonItem) {
        
    }
    
    ///Show alert if required fields are empty on save
    func showAlert(){
        
        let alert = UIAlertController(title: "Item", message: "Item must have Name and Quantity", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
