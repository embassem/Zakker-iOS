//
//  TimelineViewController.swift
//  Guest-iOS
//
//  Created by Bassem on 7/9/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import UIKit
import JTAppleCalendar

//final class TimelineViewController : UIViewController, TimelineViewDelegate {
//    var presenter: TimelinePresenter!
//    
//    @IBOutlet weak fileprivate var calendarHolder: UIView!
//
//    @IBOutlet weak fileprivate var calendarView: JTAppleCalendarView!
//    @IBOutlet weak private var timelineTableView: UITableView!
//    
//    @IBOutlet weak private var previusMonthCalenderBtn: UIButton!
//    @IBOutlet weak private var nextMonthCalenderBtn: UIButton!
//    
//    @IBOutlet weak fileprivate var currentMonthGregorianLabel: UILabel!
//    @IBOutlet weak fileprivate var currentMonthIslamicLabel: UILabel!
//    
//    @IBOutlet weak var claenderHightConstrain: NSLayoutConstraint!
//    
//    let gregorianCalendar: Calendar = Calendar(identifier: .gregorian)
//    
//    
//    @IBOutlet weak var changeViewBtn: UIBarButtonItem!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.makeAppNavBar()
//
//        print("view did load")
//        setupCalendarView()
//        
//        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0) {
//            self.calendarView.selectDates([Date()], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
//        }
//        
//        
//        
//        
////          calendarView.cellInset = CGPoint(x: 0, y: 0)
//        calendarView.cellSize = 70;
//        presenter.getTimeline()
//        timelineTableView.tableFooterView = UIView(frame: .zero)
////        self.changeViewlayoutAction(self.changeViewBtn)
////        self.calendarHolder.isHidden = true;
////        self.claenderHightConstrain.constant = 0;
////        self.changeViewBtn.tag = 1;
//         self.view.layoutIfNeeded()
//        
//        
//        
//        self.timelineTableView.addPullRefresh(options: Config.pullToRefreshOption, refreshCompletion: { [weak self] in
//            // some code
//            self?.presenter.pullToRefresh()
//            //self?.homeTableView.reloadData()
//            self?.timelineTableView.stopPullRefreshEver()
//        })
//        
//    }
//    
//    func setupCalendarView(){
//        calendarView.minimumLineSpacing = 0
//        calendarView.minimumInteritemSpacing = 0
//        
//        calendarView.visibleDates { (visibleDates) in
//            let date = visibleDates.monthDates.first!.date
//            
//self.currentMonthGregorianLabel.text = Helper.Date.getIslamicDate(date: date).georgianRegion.string(custom: "MMMM")
//self.currentMonthIslamicLabel.text = Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: "MMMM")
//            
//            
//        }
//        
//        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0) {
//            self.calendarView.selectDates([Date()], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
//        }
//        
//        
//    }
//    
//    
//    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil);
//    }
// 
//    @IBAction func nextMonth(_ sender: Any) {
//        calendarView.scrollToSegment(.next)
//        self.calendarView.reloadData()
//    }
//    @IBAction func previousMonth(_ sender: Any) {
//        calendarView.scrollToSegment(.previous)
//        self.calendarView.reloadData()
//    }
//    
//    
//    @IBAction func changeViewlayoutAction(_ sender: UIBarButtonItem) {
//        if (sender.tag == 0 ){
//          // is shown claender == true 
//            sender.tag = 1
//            self.calendarHolder.isHidden = true;
//            UIView.animate(withDuration: 1, animations: { 
//                
//               self.claenderHightConstrain.constant = 0;
//                self.view.layoutIfNeeded()
//               
//                
//            })
//            
//             presenter.getTimeline()
//        } else {
//            sender.tag = 0
//            UIView.animate(withDuration: 1, animations: {
//                
//                self.claenderHightConstrain.constant = 412 ;
//                self.view.layoutIfNeeded()
//                
//            })
//            self.calendarHolder.isHidden = false;
//             presenter.getTimelineForDate(date: Date())
//        }
//    }
//    
//    func didGetModel() {
//        
//        self.timelineTableView.reloadData()
//        
//    }
//}
//
//extension TimelineViewController:UITableViewDelegate,UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.presenter.model.events.count 
//          
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TimeLineTableViewCell else
//        {
//            return UITableViewCell()
//        };
//        
//        let event = presenter.model.events[indexPath.row];
//        
//        cell.titleLabel.text = event.title;
//        if let date = event.startDate {
//           cell.dateLabel.text =   Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: Config.fullDateTimeFormater)
//        }
//      
//        return cell;
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//         // present popup 
//        
//        if (self.presenter.model.events.count >= indexPath.row + 1){
//            let event = self.presenter.model.events[indexPath.row];
//            let vc = RouterService.getTimelineDetailsViewController(model: event);
//            self.present(vc, animated: true, completion: nil);
//        }
//    }
//}
//
//
//extension TimelineViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//        
//        let start = gregorianCalendar.date(byAdding: .year, value: -1, to: Date())!
//        let end = gregorianCalendar.date(byAdding: .year, value: 1, to: Date())!
//        
//        let parameters = ConfigurationParameters(startDate: start,
//                                                 endDate: end,
//                                                 numberOfRows: 6,
//                                                 calendar: gregorianCalendar,
//                                                 generateInDates: .forAllMonths,
//                                                 generateOutDates: .tillEndOfGrid,
//                                                 firstDayOfWeek: .sunday,
//                                                 hasStrictBoundaries: true)
//        return parameters
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
//        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "MyCell", for: indexPath) as? TimelineCalenderCell        else { return JTAppleCell() }
//        cell.configure(for: cellState)
//        cell.borderColor = UIColor.oldLace
//        cell.borderWidth  = 0
//        return cell
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        guard let cell = cell as? TimelineCalenderCell else {
//            return
//        }
//        
//       
//        
//        cell.configure(for: cellState)
//        
//        self.currentMonthGregorianLabel.text = Helper.Date.getIslamicDate(date: date).georgianRegion.string(custom: "MMMM");
//        self.currentMonthIslamicLabel.text = Helper.Date.getIslamicDate(date: date).ummAlQuraRegion.string(custom: "MMMM");
//
//        presenter.getTimelineForDate(date: cellState.date)
//        
//        cell.cellHighlight.borderColor = UIColor.otterBrown
//        cell.cellHighlight.borderWidth  = 2
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        guard let cell = cell as? TimelineCalenderCell else {
//            return
//        }
//        
//        cell.configure(for: cellState)
//        cell.cellHighlight.borderWidth  = 0
//
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
//        
//        guard let firstOfTheMonth = visibleDates.monthDates.first?.date else {
//            return
//        }
//        
//        guard let selectedDate = calendar.selectedDates.first else {
//            return
//        }
//        
//        if gregorianCalendar.component(.month, from: selectedDate) != gregorianCalendar.component(.month, from: firstOfTheMonth) {
//            calendar.selectDates([firstOfTheMonth], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
//        }
//    }
//    
//    
//        
//}
