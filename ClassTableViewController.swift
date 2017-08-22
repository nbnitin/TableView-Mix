//
//  ClassTableViewController.swift
//  TableViewMix
//
//  Created by Umesh Chauhan on 22/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {
    
    var tableData : [sections] = []

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
        return tableData[section].sectionItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SecondTableViewCell
        cell.lblTitle.text = tableData[indexPath.section].sectionItem[indexPath.row].title
        cell.lblValue.text = String(tableData[indexPath.section].sectionItem[indexPath.row].value)
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
                    
                    var tempData = sections(headerTitle: "Section 1", sectionItem: [
                        
                        items(title: "Total Seats", value: data["total_seats"] as! Int)
                        
                        
                        ])
                    self.tableData.append(tempData)
                    
                    let x = data["seating_plans"] as! [[String:Any]]
                    var Titem: [items] = []
                    
                    for i in x{
                        let tempItem = items(title: i["seating_plan_title"] as! String, value: i["seating_plan_seats"] as! Int)
                        Titem.append(tempItem)
                    }
                    
                    tempData = sections(headerTitle: "Section 2 ", sectionItem: Titem)
                    self.tableData.append(tempData)
                    
                    tempData = sections(headerTitle: "Section 3", sectionItem: [
                        items(title: "Total Buyed Seats", value: data["total_seats_buyed"] as! Int),
                        items(title: "Total Seats Left", value: data["total_seats_left"] as! Int)
                        
                        ])
                    self.tableData.append(tempData)
                    
                    tempData = sections(headerTitle: "Section 4", sectionItem: [
                        items(title: "People Checked In", value: data["user_ckecked_in"] as! Int),
                        items(title: "People Remaning", value: data["user_left"] as! Int)
                        
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
