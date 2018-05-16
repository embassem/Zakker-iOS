//
//  ViewController.swift
//  HelloCalendar
//
//  Created by Lakshay Nagpal on 20/07/17.
//  Copyright © 2017 Lakshay Nagpal. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwiftDate
import SwiftPullToRefresh

final class TimelineViewController: UIViewController, TimelineViewDelegate {
    
    enum TimelineViewType:String {
        case calender = "cellCalender"
        case timeline = "cellTimeline"
    }
    var presenter: TimelinePresenter!
    
    var monthEvents : [Event] = [];
    @IBOutlet weak var nav: UINavigationItem!
    
    
    let gregorianCalendar: Calendar = Calendar(identifier: .gregorian)
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak fileprivate var calendarHolder: UIView!
    
    @IBOutlet weak var backBarBtn: UIBarButtonItem!
    @IBOutlet weak private var timelineTableView: UITableView!
    @IBOutlet weak private var previusMonthCalenderBtn: UIButton!
    @IBOutlet weak private var nextMonthCalenderBtn: UIButton!
    
    @IBOutlet weak fileprivate var currentMonthGregorianLabel: UILabel!
    @IBOutlet weak fileprivate var currentMonthIslamicLabel: UILabel!
    
    @IBOutlet weak var claenderHightConstrain: NSLayoutConstraint!
    
    var changeViewBtn: UIButton?
    var selectedDates : [Date] = [];
    var currentViewType: TimelineViewType  = TimelineViewType.calender;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeAppNavBar()
        Helper.Analytics.contentView(name: Helper.Analytics.ContentViewName.timelineViewController)
        self.localizeBackButtonIcon(backBarBtn :backBarBtn);
        // setupCalendarView()
        
        timelineTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if (Helper.Localized.currentLanguage() == Helper.Localized.AppLanguageEnum.Arabic.rawValue){
            
            self.nextMonthCalenderBtn.setImage(#imageLiteral(resourceName: "calendar_prev"), for: .normal);
            self.previusMonthCalenderBtn.setImage(#imageLiteral(resourceName: "calendar_next"), for: .normal);
            
            
        }


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (changeViewBtn?.tag == 1){
            // table list view
            
        }else {
            //calender view
            setupCalendarView()
            
            self.calendarView.reloadData();
        }
        
        
        
        
        
    }

    

    func setupCalendarView(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { (visibleDates) in
            let date = visibleDates.monthDates.first!.date
            
        }
        
        var date = Date();
        
        
        
        if let selectedDate =  self.selectedDates.first {
            date = selectedDate;
        }
        calendarView.scrollToDate(date)
        //        calendarView.scrollToDate(date, triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0) {
        
        //            }
        self.currentMonthGregorianLabel.text = Helper.Date.getIslamicDate(date: date).georgianRegion.string(custom: Helper.Config.MonthYearDateFormater)
        self.currentMonthIslamicLabel.text = Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: Helper.Config.MonthYearDateFormater)
        self.getTimelineByMonth(month: Helper.Date.getIslamicDate(date: date).georgianRegion.month, year: Helper.Date.getIslamicDate(date: date).georgianRegion.year)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.calendarView.selectDates([date], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
            
        }
        
        
    }
    @IBAction func backAction(_ sender: Any) {
        //            self.dismiss(animated: true, completion: nil);
        
        if let nav =    self.navigationController {
            nav.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    
//    @IBAction func changeViewlayoutAction(_ sender: UIBarButtonItem) {
//        if (sender.tag == 0 ){
//            // is shown claender == true
//            sender.tag = 1
//            self.currentViewType  = TimelineViewType.timeline;
//
//            self.calendarHolder.isHidden = true;
//            UIView.animate(withDuration: 0.5, animations: {
//
//                self.claenderHightConstrain.constant = 0;
//                self.view.layoutIfNeeded()
//
//                // change icon to table
//                //                    sender.image = #imageLiteral(resourceName: "list_view");
//                // sender.setBackgroundImage(#imageLiteral(resourceName: "list_view"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
//
//
//                self.changeViewBtn?.setImage(#imageLiteral(resourceName: "calendar_view"), for: UIControlState.normal)
//                self.changeViewBtn?.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//                self.changeViewBtn?.tag = 1;
//                let barButton = UIBarButtonItem(customView: self.changeViewBtn!)
//                barButton.tag = 1
//                self.navigationItem.rightBarButtonItem = barButton
//
//
//            })
//            self.presenter.ValidateModel()
//            //                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"calendar_view"), style: .plain, target: self, action: #selector(changeViewlayoutAction))
//
//            //                self.changeViewBtn.but setBackgroundImage(UIImage(named:"calendar_view")!, for: UIControlState.normal, barMetrics: UIBarMetrics.default)
//            presenter.getTimeline()
//            Shared.HUD.progressHUD(nil, message: nil);
//        } else {
//            sender.tag = 0
//            currentViewType  = TimelineViewType.calender;
//            UIView.animate(withDuration: 0.5, animations: {
//
//                self.claenderHightConstrain.constant = 300  ;
//
//                self.view.layoutIfNeeded()
//                //                    self.calendarView.reloadData()
//                //                    sender.image = #imageLiteral(resourceName: "calendar_view");
//
//                self.changeViewBtn?.setImage(#imageLiteral(resourceName: "list_view"), for: UIControlState.normal)
//                self.changeViewBtn?.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//                self.changeViewBtn?.tag = 0;
//                let barButton = UIBarButtonItem(customView: self.changeViewBtn!)
//                barButton.tag = 0
//                self.navigationItem.rightBarButtonItem = barButton
//
//
//                // sender.setBackgroundImage(#imageLiteral(resourceName: "calendar_view"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
//            })
//
//            //                 self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"list_view"), style: .plain, target: self, action: #selector(changeViewlayoutAction))
//
//
//
//            //                self.changeViewBtn.setBackgroundImage(UIImage(named:"list_view")!, for: UIControlState.normal, barMetrics: UIBarMetrics.default)
//            self.setupCalendarView()
//            self.calendarHolder.isHidden = false;
//            //presenter.getTimelineForDate(date: Date())
//            Shared.HUD.progressHUD(nil, message: nil);
//        }
//    }
    
    
    

    
    
    
    @IBAction func nextMonth(_ sender: Any) {
        calendarView.scrollToSegment(.next)
        self.calendarView.reloadData()
    }
    @IBAction func previousMonth(_ sender: Any) {
        calendarView.scrollToSegment(.previous)
        self.calendarView.reloadData()
    }
    

}




extension TimelineViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        
        
        let start = gregorianCalendar.date(byAdding: .year, value: -1, to: Date())!
        let end =  gregorianCalendar.date(byAdding: .year, value: 1, to: Date())!
        
        //let startDate = formatter.date(from: "2017 01 01")
        
        let parameters = ConfigurationParameters(startDate: start, endDate: end,numberOfRows:5)
        
        return parameters
    }
    
    
}

extension TimelineViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    // For Displaying the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "TimelineCell", for: indexPath) as! TimelineCell
        cell.dateLabel.text = cellState.text
        
        cell.configure(for: cellState)
        if (Helper.Localized.currentLanguage() == Helper.Localized.AppLanguageEnum.Arabic.rawValue ) {
            
            cell.contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        //check if date is in month events
        
        if ( calendar.selectedDates.contains([date])){
            cell.borderColor = #colorLiteral(red: 0.4497648478, green: 0.3633997738, blue: 0.1444568336, alpha: 1)
            cell.borderWidth  = 2
            cell.backgroundColor = UIColor.paleSilver
            
        }
        var filtereddayEvents = self.monthEvents.filter { (event) -> Bool in
            return cellState.date.adding(Calendar.Component.hour, value: 14).isBetween(event.startDate!.startOfDay, event.endDate!.endOfDay,includeBounds: true)
            
        }
        if (filtereddayEvents.count > 0){
            cell.contentView.backgroundColor = UIColor.pearl
        }else {
            cell.contentView.backgroundColor = UIColor.oldLace
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.getTimeLineForDate(date: cellState.date.add(components: [Calendar.Component.hour : 12]))
        
        
        self.selectedDates = [date];
        guard let cell = cell as? TimelineCell else {
            return
        }
        
        //        cell.configure(for: cellState)
        
        self.currentMonthGregorianLabel.text = Helper.Date.getIslamicDate(date: date).georgianRegion.string(custom: Helper.Config.MonthYearDateFormater);
        self.currentMonthIslamicLabel.text = Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: Helper.Config.MonthYearDateFormater);
        
        
        cell.borderColor = #colorLiteral(red: 0.4497648478, green: 0.3633997738, blue: 0.1444568336, alpha: 1)
        cell.borderWidth  = 2
        cell.backgroundColor = UIColor.paleSilver
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let cell = cell as? TimelineCell else {
            return
        }
        
        cell.borderWidth  = 0
        cell.backgroundColor = UIColor.clear
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.calendarView.deselectAllDates()
        self.currentMonthGregorianLabel.text = Helper.Date.getIslamicDate(date: date).georgianRegion.string(custom: Helper.Config.MonthYearDateFormater);
        self.currentMonthIslamicLabel.text = Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: Helper.Config.MonthYearDateFormater);
        
        self.getTimelineByMonth(month: Helper.Date.getIslamicDate(date: date).georgianRegion.month, year: Helper.Date.getIslamicDate(date: date).georgianRegion.year)
        //self.getTimelineByMonth(month: date.month, year: date.year)
        
    }
    
    
    
    
    
}



