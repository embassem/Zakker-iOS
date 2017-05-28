//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit
import AFDateHelper

class SwiftViewController: UIViewController {
    
    var startdate:Date = Date(fromString: "2017-05-27T12:00+02:00", format: DateFormatType.isoDateTime)!; //   Date(timeInterval: "2017-05-26", since: ));//DateFormat.iso8601(nil
    
    @IBOutlet weak var calenderTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("Icon sidebar",rightImageName: nil)
    }
    
    @IBAction func togleLeftMenu(_ sender:UIButton){
        
        self.toggleLeft()
    }
    
    
}
extension SwiftViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero);
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return  UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as! dateTableViewCell;
        
        cell.cellDate = startdate.adjust(.day, offset: indexPath.row);
        cell.setIslamicDate();
        
        return cell;
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! dateTableViewCell;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        mainViewController.todayDate = cell.cellDate;
        self.slideMenuController()?.changeMainViewController(mainViewController, close: true)
        
    }
    
    
}
