//
//  ViewController.swift
//  TableViewWithAction
//
//  Created by nitin bhatia on 1/17/18.
//  Copyright © 2018 nitin bhatia. All rights reserved.
//

import UIKit

class CountModel{
    var number : Int
    init(number : Int){
        self.number = number
    }
}

class ViewController: UITableViewController {
    
    var data : [CountModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0...9{
            let temp = CountModel(number: 0)
            data.append(temp)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.lblCount.text = "\(data[indexPath.row].number)"
        cell.btnPlus.tag = indexPath.row
        cell.btnMinus.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: #selector(btnAdd), for: .touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(btnMinus), for: .touchUpInside)
        return cell
    }
    
    @objc func btnAdd(_ sender: UIButton){
        data[sender.tag].number = data[sender.tag].number + 1
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.lblCount.text = "\(data[sender.tag].number)"
    }
    
    @objc func btnMinus(_ sender: UIButton){
        data[sender.tag].number = data[sender.tag].number - 1
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.lblCount.text = "\(data[sender.tag].number)"
    }
}

