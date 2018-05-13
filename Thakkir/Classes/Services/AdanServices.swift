//
//  AdanServices.swift
//  Thakkir
//
//  Created by Bassem Abbas on 6/3/16.
//  Copyright © 2016 Bassem Abbas. All rights reserved.
//

import Foundation
import Adhan
import RealmSwift
import CoreLocation
import AFDateHelper



class AdanServices{
    
    class  func calculateAdan(_ userLocation:CLLocation,date:Date) ->  Void {
        
        
        
        
        
        
        let normalCalender = Calendar.current; 
        
        
        let day :Date =  normalCalender.startOfDay(for: date)
        //        let startDate :NSDate =  day.dateByAddingSeconds(NSTimeZone.localTimeZone().secondsFromGMT)NSCalendar.Unit(rawValue: 0)
        let date = (normalCalender as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: day)
        
        let islamicCalender = Calendar(identifier: Calendar.Identifier.islamicUmmAlQura);
        let components = (islamicCalender as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: day)
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current//(identifier: "ar_EG")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = .none
        dateFormatter.calendar = islamicCalender;
        
        //        
        //        print("test formater :  \( dateFormatter.stringFromDate(components.date!))");
        //        var dateqq:String = "\(formatter.stringFromNumber(components.year))-\(formatter.stringFromNumber(components.month))-\(formatter.stringFromNumber(components.day))"
        //        
        //        print("Date in system calendar:\(date), in Hijri:\(components.year)-\(components.month)-\(components.day)  , \(components.date)")
        //        
        //        
        let coordinates = Coordinates(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        var params = CalculationMethod.egyptian.params; //CalculationMethod.MuslimWorldLeague.params
        //        params.madhab = .Shafi
        //        params.method = CalculationMethod.Egyptian;
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let startDate = date.date?.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()));
            self.updateSavedRecourd(startDate!,prayers: prayers);
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.timeZone = Foundation.TimeZone.autoupdatingCurrent
            
            NSLog("fajr %@", formatter.string(from: prayers.fajr))
            NSLog("sunrise %@", formatter.string(from: prayers.sunrise))
            NSLog("dhuhr %@", formatter.string(from: prayers.dhuhr))
            NSLog("asr %@", formatter.string(from: prayers.asr))
            NSLog("maghrib %@", formatter.string(from: prayers.maghrib))
            NSLog("isha %@", formatter.string(from: prayers.isha))
            
        }
        
    }
    
    class func updateSavedRecourd(_ date:Date,prayers:PrayerTimes){
        
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            print("This is run on the background queue")
            
            //            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //                print("This is run on the main queue, after the previous code in outer block")
            //            })
            
            
            for index in 0...6 {
                print(index)
                let calculatedDate =   date.dateByAddingDay(index);
                print (calculatedDate)
                
                
                var thakkirDay : Thakkir?
                
                
                // Get the default Realm
                let realm = try! Realm()
                // You only need to do this once (per thread)
                
                let predicate = NSPredicate(format: "DayMelady = %@ ", calculatedDate as CVarArg); //NSPredicate(format: "DayMelady = %@ ",calculatedDate)
                thakkirDay = realm.objects(Thakkir.self).filter(predicate).first
                
                if(thakkirDay == nil){
                    thakkirDay = Thakkir();
                    thakkirDay!.id = thakkirDay!.IncrementaID();
                    thakkirDay?.DayMelady  = calculatedDate
                    
                }
                
                
                try! realm.write {
                    
                    thakkirDay?.fajrTime = prayers.fajr;
                    thakkirDay?.sunriseTime = prayers.sunrise;
                    thakkirDay?.dhuhrTime = prayers.dhuhr;
                    thakkirDay?.asrTime = prayers.asr;
                    thakkirDay?.maghribTime = prayers.maghrib;
                    thakkirDay?.ishaTime = prayers.isha;
                    
                    
                    realm.add(thakkirDay!, update: true)
                    
                }
                
                //                let notificationEmsakId = "\(thakkirDay!.id)-Emsak";
                //                self.cancelNotification(notificationEmsakId)
                //                let notificationEmsak : UILocalNotification = UILocalNotification()
                //                notificationEmsak.timeZone = NSTimeZone.localTimeZone()
                //                notificationEmsak.alertBody = "وقت الامساك"
                //                notificationEmsak.userInfo = ["id": notificationEmsakId ,"Type":"2"]
                //                notificationEmsak.fireDate = prayers.fajr.dateBySubtractingMinutes(5)
                //                notificationEmsak.soundName = "adan.mp3";
                //                UIApplication.sharedApplication().scheduleLocalNotification(notificationEmsak)
                //                
//                //                
//                                let notificationFajrId = "\(thakkirDay!.id)-fajr";
//                                self.cancelNotification(notificationFajrId)
//                                let notificationFajr : UILocalNotification = UILocalNotification()
//                                notificationFajr.timeZone = NSTimeZone.localTimeZone()
//                                notificationFajr.alertBody = "صلاة الفجر"
//                                notificationFajr.userInfo = ["id":notificationFajrId ,"Type":"0" ]
//                                notificationFajr.fireDate = prayers.fajr
////                                notificationFajr.soundName = "adan.mp3";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationFajr)
//                                
//                                
//                                let   notificationSunriseId =  "\(thakkirDay!.id)-sunrise"
//                                self.cancelNotification(notificationSunriseId)
//                                let notificationSunrise : UILocalNotification = UILocalNotification()
//                                notificationSunrise.timeZone = NSTimeZone.localTimeZone()
//                                notificationSunrise.alertBody = "وقت الشروق"
//                                notificationSunrise.fireDate = prayers.sunrise
//                                notificationSunrise.userInfo = ["id": notificationSunriseId ,"Type":"1"]
////                                notificationSunrise.soundName = "adan.mp3";
//                
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationSunrise)
//                                
//                                let notificationDhuhrId = "\(thakkirDay!.id)-dhuhr";
//                                self.cancelNotification(notificationDhuhrId)
//                                
//                                let notificationDhuhr : UILocalNotification = UILocalNotification()
//                                notificationDhuhr.timeZone = NSTimeZone.localTimeZone()
//                                notificationDhuhr.alertBody = "صلاه الظهر"
//                                notificationDhuhr.fireDate = prayers.dhuhr
//                                notificationDhuhr.userInfo = ["id": notificationDhuhrId,"Type":"0" ]
////                                notificationDhuhr.soundName = "adan.mp3";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationDhuhr)
//                                
//                                let notificationAsrId = "\(thakkirDay!.id)-asr";
//                                self.cancelNotification(notificationAsrId)
//                                let notificationAsr : UILocalNotification = UILocalNotification()
//                                notificationAsr.timeZone = NSTimeZone.localTimeZone()
//                                notificationAsr.alertBody = "صلاة العصر"
//                                notificationAsr.fireDate = prayers.asr
//                                notificationAsr.userInfo = ["id": notificationAsrId  ,"Type":"0"]
////                                notificationAsr.soundName = "adan.mp3";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationAsr)
//                                
//                                
//                                
//                                let notificationEftarId = "\(thakkirDay!.id)-Eftar"
//                                self.cancelNotification(notificationEftarId)
//                                let notificationEftar : UILocalNotification = UILocalNotification()
//                                notificationEftar.timeZone = NSTimeZone.localTimeZone()
//                                notificationEftar.alertBody = "وقت الافطار"
//                                notificationEftar.fireDate = prayers.maghrib
//                                notificationEftar.userInfo = ["id": notificationEftarId ,"Type":"3"]
////                                notificationEftar.soundName = "adan.mp3";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationEftar)
//                                
//                                
//                                let  notificationMaghribId = "\(thakkirDay!.id)-maghrib" ;
//                                self.cancelNotification(notificationMaghribId)
//                                let notificationMaghrib : UILocalNotification = UILocalNotification()
//                                notificationMaghrib.timeZone = NSTimeZone.localTimeZone()
//                                notificationMaghrib.alertBody = "صلاة المغرب"
//                                notificationMaghrib.fireDate = prayers.maghrib.dateByAddingSeconds(10);
//                                notificationMaghrib.userInfo = ["id": notificationMaghribId ,"Type":"0"]
////                                notificationMaghrib.soundName = "Untitled";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationMaghrib)
//                                
//                                
//                                
//                                let notificationIshaId = "\(thakkirDay!.id)-isha";
//                                self.cancelNotification(notificationIshaId)
//                                let notificationIsha : UILocalNotification = UILocalNotification()
//                                notificationIsha.timeZone = NSTimeZone.localTimeZone()
//                                notificationIsha.alertBody = "صلاة العشاء"
//                                notificationIsha.fireDate = prayers.isha
//                                notificationIsha.userInfo = ["id": notificationIshaId ,"Type":"0"]
////                                notificationIsha.soundName = "adan.mp3";
//                                UIApplication.sharedApplication().scheduleLocalNotification(notificationIsha)
                //
                //                
                
                
                
                //                
                //                                let testId = "testId";
                //                                self.cancelNotification(testId)
                //                        let notificationTest : UILocalNotification = UILocalNotification()
                //                
                //                
                //                
                //                        notificationTest.timeZone = NSTimeZone.localTimeZone()
                //                        notificationTest.alertBody = "testId"
                //                        notificationTest.fireDate = NSDate().dateByAddingSeconds(5);
                //                        notificationTest.userInfo = ["id": testId ,"Type":3,"content-available":1]
                //                
                //                        notificationTest.soundName = "adan.mp3"// UILocalNotificationDefaultSoundName ;
                //                        UIApplication.sharedApplication().scheduleLocalNotification(notificationTest)
                //                
            }
            
        });
    }
    
    
    class func cancelNotification(_ id:String) ->  Void {
        
        
        
        
        for notification:UILocalNotification in UIApplication.shared.scheduledLocalNotifications! {
            print("not id = \(notification.userInfo!["id"])   == \(id)")
            if (notification.userInfo!["id"] as! String == id) {
                
                UIApplication.shared.cancelLocalNotification(notification);
                
            }
            
        }
        
    }
    
    
    
}
