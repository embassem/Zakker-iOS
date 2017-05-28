//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SlideMenuControllerSwift
import CoreLocation
import Adhan
import RealmSwift
import AVFoundation
import CoreAudio
import Crashlytics

var appDelegate = UIApplication.shared.delegate as! AppDelegate


class MainViewController: UIViewController {
    
    
    
    
    
    
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblFajrTime: UILabel!
    
    @IBOutlet weak var lbldhuhrTime: UILabel!
    
    @IBOutlet weak var lblAsrTime: UILabel!
    
    @IBOutlet weak var lblMaghribTime: UILabel!
    
    @IBOutlet weak var lblIshaTime: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    
    @IBOutlet weak var lblQeyamTime: UILabel!
    
    @IBOutlet weak var lblTahajodTime: UILabel!
    
    
    
    @IBOutlet weak var fajrPray : UIButton!
    @IBOutlet weak var dhuhrPray : UIButton!
    @IBOutlet weak var asrPray : UIButton!
    @IBOutlet weak var maghribPray : UIButton!
    @IBOutlet weak var ishaPray : UIButton!
    @IBOutlet weak var fajrSona : UIButton!
    @IBOutlet weak var dhuhrSona : UIButton!
    @IBOutlet weak var asrSona : UIButton!
    @IBOutlet weak var maghribSona : UIButton!
    @IBOutlet weak var ishaSona : UIButton!
    @IBOutlet weak var sunriseSona : UIButton!
    @IBOutlet weak var fajrGamaa : UIButton!
    @IBOutlet weak var dhuhrGamaa : UIButton!
    @IBOutlet weak var asrGamaa : UIButton!
    @IBOutlet weak var maghribGamaa : UIButton!
    @IBOutlet weak var ishaGamaa : UIButton!
    @IBOutlet weak var fajrTasbeeh : UIButton!
    @IBOutlet weak var dhuhrTasbeeh : UIButton!
    @IBOutlet weak var asrTasbeeh : UIButton!
    @IBOutlet weak var maghribTasbeeh : UIButton!
    @IBOutlet weak var ishaTasbeeh : UIButton!
    @IBOutlet weak var salatQeyam : UIButton!
    @IBOutlet weak var salatTahagod : UIButton!
    @IBOutlet weak var salatNehayetElSalat: UIButton!
    @IBOutlet weak var fajrEstagfar : UIButton!
    @IBOutlet weak var dhuhrEstagfar : UIButton!
    @IBOutlet weak var asrEstagfar: UIButton!
    @IBOutlet weak var maghribEstagfar : UIButton!
    @IBOutlet weak var ishaEstagfar : UIButton!
    @IBOutlet weak var Quran1 : UIButton!
    @IBOutlet weak var Quran2 : UIButton!
    @IBOutlet weak var Quran3 : UIButton!
    @IBOutlet weak var Quran4 : UIButton!
    @IBOutlet weak var Quran5 : UIButton!
    
    
    //MARK:- Variables
    let realm = try! Realm()
    var thakkirDay : Thakkir?
    
    var todayDate:Date?
    var locationManager:CLLocationManager!
    var geocoder = CLGeocoder()
    var placeMark : CLPlacemark?
    var userLocation:CLLocation?{
        didSet{
            
            //MARK:-TODO//Call AdanService to update Adan Data
        }
    }
    
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLocationManager()

        
        if (self.todayDate == nil) {
            self.todayDate = Date.GetDateOnly();
            
        }else {
            let normalCalender = Calendar(identifier: Calendar.Identifier.iso8601)
            
            let day :Date =  normalCalender.startOfDay(for: self.todayDate!)
            
            let dateComponents = (normalCalender as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: day)
            
            let startDate = dateComponents.date?.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
            
            self.todayDate = startDate;
        }
        // self.tableView.registerCellNib(DataTableViewCell.self)
        
        
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("Icon sidebar",rightImageName: nil)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
         if CLLocationManager.authorizationStatus() == .notDetermined  || CLLocationManager.authorizationStatus() == .denied  {
        let alert  = UIAlertController(title: "Alert", message: "Zakker is using Location to Calculate the Pray times for your current Location,\nPlease Enable Location to allow the app Functionality .", preferredStyle: .alert);
        
        let okAction = UIAlertAction(title: "Allow", style: .default) { (action) in
            
          self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestLocation();
            
        }
        
        
            
            
            

            
        alert.addAction(okAction);
        
            
            self.present(alert, animated: true, completion: nil);
        
       
            
           
            
        }
    }
    func GetCityName(){
        if (self.locationManager.location != nil){
            AdanServices.calculateAdan(self.locationManager.location!,date: self.todayDate!)
            
            geocoder.reverseGeocodeLocation(locationManager.location!, completionHandler: { (placeMarks, error) -> Void in
                if error == nil && placeMarks!.count > 0 {
                    //println(placeMarks[0])
                    self.placeMark = placeMarks![0] as? CLPlacemark
                    if let city = self.placeMark?.locality {
                        print(city)
                        // TODO: Track the user action that is important for you.
                        Answers.logLevelStart("Home", customAttributes: ["city":city]);
                        
                        self.lblLocation.text = city;
                    }
                } else {
                    print(error)
                }
                
            })
        }
        fillSectionWithData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func togleLeftMenu(_ sender:UIButton){
        
        self.toggleLeft()
    }
    
    
    
    func initLocationManager() {
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers//kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates = false;
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.activityType = CLActivityType.other;
        //   self.locationManager.distanceFilter = kCLDistanceFilterNone;
        //    locationManager.distanceFilter = CLLocationDistance
//        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation();
        //        if (self.locationManager.locationServicesEnabled == false ) {
        //
        //        }
    }
    
    func fillSectionWithData(){
        //        let normalCalender = NSCalendar(identifier: NSCalendarIdentifierISO8601)!
        //        
        //        let day :NSDate =  normalCalender.startOfDayForDate(NSDate())
        //        
        //        let dateComponents = normalCalender.components(NSCalendarUnit(rawValue: UInt.max), fromDate: day)
        //        
        //          let startDate = dateComponents.date!.dateByAddingSeconds(NSTimeZone.localTimeZone().secondsFromGMT)
        
        let islamicCalender = Calendar(identifier: Calendar.Identifier.islamicUmmAlQura);
        //        let components = islamicCalender.components(NSCalendarUnit(rawValue: UInt.max), fromDate: day)
        //
        //        let arFormatter = NSNumberFormatter()
        //        arFormatter.locale = NSLocale(localeIdentifier: "ar_SA")
        
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "MMM dd YYYY"
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = .none
        dateFormatter.calendar = islamicCalender;
        
        lblDate.text =   dateFormatter.string(  from: self.todayDate!);
        lblDate.sizeToFit();
        
        
        
        
        // Get the default Realm
        
        // You only need to do this once (per thread)
        
        let predicate = NSPredicate(format: "DayMelady = %@ ",  self.todayDate! as CVarArg)
        thakkirDay = realm.objects(Thakkir.self).filter(predicate).first
        
        
        
        let formatter = DateFormatter()
        //formatter.timeStyle = .MediumStyle
        formatter.dateFormat = "h:mm a";
        formatter.timeZone = Foundation.TimeZone.autoupdatingCurrent
        
        
        //        thakkirDay?.fajrTime = prayers.fajr;
        //        thakkirDay?.sunriseTime = prayers.sunrise;
        //        thakkirDay?.dhuhrTime = prayers.dhuhr;
        //        thakkirDay?.asrTime = prayers.asr;
        //        thakkirDay?.maghribTime = prayers.maghrib;
        //        thakkirDay?.ishaTime = prayers.isha;
        
        if (thakkirDay != nil) {
            
            let fajr = formatter.string(
                from: (thakkirDay!.fajrTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let fajr2 = fajr.replacingOccurrences(of: "PM", with: "م");
            
            lblFajrTime.text = fajr2;
            
            
            
            let dhuhr = formatter.string(
                from: (thakkirDay!.dhuhrTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let dhuhr2 = dhuhr.replacingOccurrences(of: "PM", with: "م");
            
            lbldhuhrTime.text = dhuhr2;
            
            
            let asr = formatter.string(
                from: (thakkirDay!.asrTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let asr2 = asr.replacingOccurrences(of: "PM", with: "م");
            
            
            
            lblAsrTime.text = asr2;
            
            
            
            
            let maghrib = formatter.string(
                from: (thakkirDay!.maghribTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let maghrib2 = maghrib.replacingOccurrences(of: "PM", with: "م");
            
            
            
            lblMaghribTime.text = maghrib2;
            
            
            
            let isha = formatter.string(
                from: (thakkirDay!.ishaTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let isha2 = isha.replacingOccurrences(of: "PM", with: "م");
            
            
            
            
            lblIshaTime.text = isha2;
            
            
            
            
            let sunriseTime = formatter.string(
                from: (thakkirDay!.sunriseTime) as Date).replacingOccurrences(of: "AM", with: "ص");
            let sunriseTime2 = sunriseTime.replacingOccurrences(of: "PM", with: "م");
            
            
            
            
            lblSunriseTime.text = sunriseTime2;
            
            
            let QeyamTime = formatter.string(
                from: ((thakkirDay!.ishaTime.adjust(.minute, offset: 30)))).replacingOccurrences(of: "AM", with: "ص");
            let QeyamTime2 = QeyamTime.replacingOccurrences(of: "PM", with: "م");
            
            
            
            
            lblQeyamTime.text = QeyamTime2;//formatter.stringFromDate( (thakkirDay!.ishaTime.dateByAddingMinutes(30)));
            
            
            let TahajodTime = formatter.string(
                from: ((thakkirDay!.fajrTime.adjust(hour: -2, minute: 0, second: 0)))).replacingOccurrences(of: "AM", with: "ص");
            let TahajodTime2 = TahajodTime.replacingOccurrences(of: "PM", with: "م");
            
            
            
            lblTahajodTime.text = TahajodTime2;//formatter.stringFromDate((thakkirDay!.fajrTime.dateBySubtractingMinutes(120)));
            
            
            
            
            //MARK:-Setting 34 TODO
            
            
            //fajr
            if(thakkirDay!.fajrGamaa == true){
                fajrGamaa.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                fajrGamaa.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.fajrEstagfar == true){
                fajrEstagfar.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                fajrEstagfar.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.fajrTasbeeh == true){
                fajrTasbeeh.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                fajrTasbeeh.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.fajrSona == true){
                fajrSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                fajrSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.fajrPray == true){
                fajrPray.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                fajrPray.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            
            //dohr
            if(thakkirDay!.dhuhrGamaa == true){
                dhuhrGamaa.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                dhuhrGamaa.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.dhuhrEstagfar == true){
                dhuhrEstagfar.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                dhuhrEstagfar.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.dhuhrTasbeeh == true){
                dhuhrTasbeeh.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                dhuhrTasbeeh.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.dhuhrSona == true){
                dhuhrSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                dhuhrSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.dhuhrPray == true){
                dhuhrPray.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                dhuhrPray.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            //asr
            if(thakkirDay!.asrGamaa == true){
                asrGamaa.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                asrGamaa.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.asrEstagfar == true){
                asrEstagfar.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                asrEstagfar.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.asrTasbeeh == true){
                asrTasbeeh.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                asrTasbeeh.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.asrSona == true){
                asrSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                asrSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.asrPray == true){
                asrPray.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                asrPray.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            
            
            
            //asr
            if(thakkirDay!.maghribGamaa == true){
                maghribGamaa.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                maghribGamaa.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.maghribEstagfar == true){
                maghribEstagfar.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                maghribEstagfar.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.maghribTasbeeh == true){
                maghribTasbeeh.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                maghribTasbeeh.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.maghribSona == true){
                maghribSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                maghribSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.maghribPray == true){
                maghribPray.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                maghribPray.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            
            //asr
            if(thakkirDay!.ishaGamaa == true){
                ishaGamaa.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                ishaGamaa.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.ishaEstagfar == true){
                ishaEstagfar.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                ishaEstagfar.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.ishaTasbeeh == true){
                ishaTasbeeh.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                ishaTasbeeh.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.ishaSona == true){
                ishaSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                ishaSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.ishaPray == true){
                ishaPray.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                ishaPray.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }

            
            
            if(thakkirDay!.sunriseSona == true){
                sunriseSona.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                sunriseSona.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            

            if(thakkirDay!.salatQeyam == true){
                salatQeyam.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                salatQeyam.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            if(thakkirDay!.salatTahagod == true){
                salatTahagod.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                salatTahagod.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            if(thakkirDay!.salatNehayetElSalat == true){
                salatNehayetElSalat.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                salatNehayetElSalat.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }

            
            
            
            
            
            
            
            //Quraan
            if(thakkirDay!.Quran1 == true){
                Quran1.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                Quran1.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            if(thakkirDay!.Quran2 == true){
                Quran2.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                Quran2.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            if(thakkirDay!.Quran3 == true){
                Quran3.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                Quran3.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            if(thakkirDay!.Quran4 == true){
                Quran4.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                Quran4.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            if(thakkirDay!.Quran5 == true){
                Quran5.setBackgroundImage(UIImage(named: "Check"), for: .normal)
            }else {
                Quran5.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            
            
            
        }
        //        NSLog("fajr %@", formatter.stringFromDate(prayers.fajr))
        //        NSLog("sunrise %@", formatter.stringFromDate(prayers.sunrise))
        //        NSLog("dhuhr %@", formatter.stringFromDate(prayers.dhuhr))
        //        NSLog("asr %@", formatter.stringFromDate(prayers.asr))
        //        NSLog("maghrib %@", formatter.stringFromDate(prayers.maghrib))
        //        NSLog("isha %@", formatter.stringFromDate(prayers.isha))
        
        
        
        
    }
    
}


//extension MainViewController : UITableViewDelegate {
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return DataTableViewCell.height()
//    }
//}
//
//extension MainViewController : UITableViewDataSource {
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.mainContens.count
//    }
//     
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCellWithIdentifier(DataTableViewCell.identifier) as! DataTableViewCell
//        let data = DataTableViewCellData(imageUrl: "dummy", text: mainContens[indexPath.row])
//        cell.setData(data)
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
//        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
//        self.navigationController?.pushViewController(subContentsVC, animated: true)
//    }
//}


//MARK:- todoExtention Fajr IBAction
extension MainViewController  {
    
    @IBAction func UpdatefajrPray(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.fajrPray = !thakkirDay!.fajrPray;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.fajrPray == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdatefajrSona(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.fajrSona = !thakkirDay!.fajrSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.fajrSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdatefajrGamaa(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.fajrGamaa = !thakkirDay!.fajrGamaa;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.fajrGamaa == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateFajrTasbeeh(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.fajrTasbeeh = !thakkirDay!.fajrTasbeeh;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.fajrTasbeeh == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateFajrEstagfar(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.fajrEstagfar = !thakkirDay!.fajrEstagfar;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.fajrEstagfar == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    
    
    
}

//MARK:- todoExtention Dohur IBAction
extension MainViewController  {
    
    @IBAction func UpdateDhuhrPray(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.dhuhrPray = !thakkirDay!.dhuhrPray;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.dhuhrPray == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateDhuhrSona(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.dhuhrSona = !thakkirDay!.dhuhrSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.dhuhrSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateDhuhrGamaa(_ sender:UIButton){
       
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.dhuhrGamaa = !thakkirDay!.dhuhrGamaa;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.dhuhrGamaa == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateDhuhrTasbeeh(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.dhuhrTasbeeh = !thakkirDay!.dhuhrTasbeeh;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.dhuhrTasbeeh == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateDhuhrEstagfar(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.dhuhrEstagfar = !thakkirDay!.dhuhrEstagfar;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.dhuhrEstagfar == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    
    
    
}

//MARK:- todoExtention ASR IBAction
extension MainViewController  {
    
    @IBAction func UpdateAsrPray(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.asrPray = !thakkirDay!.asrPray;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.asrPray == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateAsrSona(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.asrSona = !thakkirDay!.asrSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.asrSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateAsrGamaa(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        try! realm.write {
            
            thakkirDay!.asrGamaa = !thakkirDay!.asrGamaa;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.asrGamaa == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateAsrTasbeeh(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        
        try! realm.write {
            
            thakkirDay!.asrTasbeeh = !thakkirDay!.asrTasbeeh;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.asrTasbeeh == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateAsrEstagfar(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
        
        try! realm.write {
            
            thakkirDay!.asrEstagfar = !thakkirDay!.asrEstagfar;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.asrEstagfar == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    
    
    
}


//MARK:- todoExtention Maghrib IBAction
extension MainViewController  {
    
    @IBAction func UpdateMaghribPray(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        
        try! realm.write {
            
            thakkirDay!.maghribPray = !thakkirDay!.maghribPray;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.maghribPray == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateMaghribSona(_ sender:UIButton){
        guard let thakkir = thakkirDay else {
            return
        }
        

        
        try! realm.write {
            
            thakkirDay!.maghribSona = !thakkirDay!.maghribSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.maghribSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateMaghribGamaa(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        try! realm.write {
            
            thakkirDay!.maghribGamaa = !thakkirDay!.maghribGamaa;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.maghribGamaa == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateMaghribTasbeeh(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        try! realm.write {
            
            thakkirDay!.maghribTasbeeh = !thakkirDay!.maghribTasbeeh;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.maghribTasbeeh == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateMaghribEstagfar(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        try! realm.write {
            
            thakkirDay!.maghribEstagfar = !thakkirDay!.maghribEstagfar;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.maghribEstagfar == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    
    
    
}

//MARK:- todoExtention Isa IBAction
extension MainViewController  {
    
    @IBAction func UpdateIsaPray(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        
        
        try! realm.write {
            
            thakkirDay!.ishaPray = !thakkirDay!.ishaPray;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.ishaPray == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateIshaSona(_ sender:UIButton){
        
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        
        try! realm.write {
            
            thakkirDay!.ishaSona = !thakkirDay!.ishaSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.ishaSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateIshaGamaa(_ sender:UIButton){
        
      
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        
        try! realm.write {
            
            thakkirDay!.ishaGamaa = !thakkirDay!.ishaGamaa;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.ishaGamaa == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateIshaTasbeeh(_ sender:UIButton){
        
        
     
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        try! realm.write {
            
            thakkirDay!.ishaTasbeeh = !thakkirDay!.ishaTasbeeh;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.ishaTasbeeh == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateIshaEstagfar(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        

        try! realm.write {
            
            thakkirDay!.ishaEstagfar = !thakkirDay!.ishaEstagfar;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.ishaEstagfar == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    
    
    
}



//MARK:- todoExtention Quran IBAction
extension MainViewController {
    
    @IBAction func UpdateQuran1(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
 
        try! realm.write {
            
            thakkirDay!.Quran1 = !thakkirDay!.Quran1;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.Quran1 == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateQuran2(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
 
        
        try! realm.write {
            
            thakkirDay!.Quran2 = !thakkirDay!.Quran2;
            realm.add(thakkirDay!, update: true)
            
        }
        if(thakkirDay!.Quran2 == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
    }
    @IBAction func UpdateQuran3(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        
   
        try! realm.write {
            
            thakkirDay!.Quran3 = !thakkirDay!.Quran3;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.Quran3 == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
    }
    @IBAction func UpdateQuran4(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        
  
        try! realm.write {
            
            thakkirDay!.Quran4 = !thakkirDay!.Quran4;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.Quran4 == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    @IBAction func UpdateQuran5(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        
  
        try! realm.write {
            
            thakkirDay!.Quran5 = !thakkirDay!.Quran5;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.Quran5 == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    
}
//MARK:- todoExtention TodaySection  IBAction
extension MainViewController  {
    
    @IBAction func UpdatefSunriseSons(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
   
        
        try! realm.write {
            
            thakkirDay!.sunriseSona = !thakkirDay!.sunriseSona;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.sunriseSona == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    @IBAction func UpdateQeyam(_ sender:UIButton){
        
        
        guard let thakkir = thakkirDay else {
            return
        }
        
  
        try! realm.write {
            
            thakkirDay!.salatQeyam = !thakkirDay!.salatQeyam;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.salatQeyam == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    @IBAction func UpdateTahagod(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
  
        
        try! realm.write {
            
            thakkirDay!.salatTahagod = !thakkirDay!.salatTahagod;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.salatTahagod == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    
    
    @IBAction func UpdateShaf3andWater(_ sender:UIButton){
        
        guard let thakkir = thakkirDay else {
            return
        }
        
        
        
        try! realm.write {
            
            thakkirDay!.salatNehayetElSalat = !thakkirDay!.salatNehayetElSalat;
            realm.add(thakkirDay!, update: true)
            
        }
        
        if(thakkirDay!.salatNehayetElSalat == true){
            sender.setBackgroundImage(UIImage(named: "Check"), for: .normal)
        }else {
            sender.setBackgroundImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        
    }
    
    
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

extension MainViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.stopUpdatingLocation()
        
        self.userLocation = locations.last;
        self.GetCityName();
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error);
    }
    
}



