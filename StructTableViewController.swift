//
//  StructTableViewController.swift
//  TableViewMix
//
//  Created by Nitin Bhatia on 22/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

struct item{
    var title:String
    var value:Int
    
    init(title : String,value :Int) {
        self.title = title
        self.value = value
    }
}

struct section{
    var headerTitle:String
    var items : [item]
    
    init(headerTitle :String,items:[item]) {
        self.headerTitle = headerTitle
        self.items = items
    }
}

class StructTableViewController: UITableViewController {
    
    var tableData : [section] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        readJSONFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lblTitle.text = tableData[indexPath.section].items[indexPath.row].title
        cell.lblValue.text = String(tableData[indexPath.section].items[indexPath.row].value)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func readJSONFile(){
        
        
        if let path = Bundle.main.path(forResource: "new", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonResult: NSDictionary =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    print(jsonResult)
                    let data = jsonResult["response"] as! NSDictionary
                    
                    var tempData = section(headerTitle: "Section 1", items: [
                        
                        item(title: "Total Seats", value: data["total_seats"] as! Int)
                      
                        
                        ])
                    self.tableData.append(tempData)
                    
                    let x = data["seating_plans"] as! [[String:Any]]
                    var Titem: [item] = []
                    
                    for i in x{
                        let tempItem = item(title: i["seating_plan_title"] as! String, value: i["seating_plan_seats"] as! Int)
                        Titem.append(tempItem)
                    }
                    
                    tempData = section(headerTitle: "Section 2 ", items: Titem)
                    self.tableData.append(tempData)
                    
                    tempData = section(headerTitle: "Section 3", items: [
                        item(title: "Total Buyed Seats", value: data["total_seats_buyed"] as! Int),
                        item(title: "Total Seats Left", value: data["total_seats_left"] as! Int)
                        
                        ])
                    self.tableData.append(tempData)
                    
                    tempData = section(headerTitle: "Section 4", items: [
                        item(title: "People Checked In", value: data["user_ckecked_in"] as! Int),
                        item(title: "People Remaning", value: data["user_left"] as! Int)
                        
                        ])
                    self.tableData.append(tempData)
                    
                    
                    self.tableView.reloadData()

                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }

}
