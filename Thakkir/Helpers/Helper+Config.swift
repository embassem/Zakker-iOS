//
//  Helper+Config.swift
//  Guest-iOS
//
//  Created by Bassem on 2/25/18.
//  Copyright © 2018 Ibtikar. All rights reserved.
//

import CoreLocation

extension Helper {
    
    struct Config {
        // swiftlint:disable identifier_name
        
        static let kabahLocation = CLLocation(latitude: 21.4235841, longitude: 39.8311565)
        static let GOOGLE_MAP_INITIAL_LOCATION:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 21.4235841, longitude: 39.8311565)
        static let GOOGLE_MAP_INITIAL_ZOME: Float = 12.0;
        static let LOCATION_SERVICE_FILTER_DISTANCE = 100.0;
        static let LOCATION_SERVICE_ACCURACY = kCLLocationAccuracyThreeKilometers
        static let  FlurryKey = "4HNZ5P9N7GC77N3ZN9VV"
        static let fullDateTimeFormater = "dd MMMM yyyy  h:mm a ";
        static let shortMonthDateFormater = "dd MMM yyyy";
        static let fullMonthDateFormater = "dd MMMM yyyy";
        static let MonthYearDateFormater = "MMMM yyyy";
        static let MonthOnlyDateFormater = "MMMM";
        static let FlightInfoFormat = "dd MMM";
        static let shortTimeDateFormater = "h:mm a";
        static let dayDateFormater = "EEEE";
        static let youtubeDateFormater = "yyyy-MM-dd'T'HH:mm:ss'Z'";
        static let youtubeAPIKey = "AIzaSyCIo5XkLE6dGWKWDL7x2SJFisNTcGA-TP4"
        static let gcmMessageIDKey = "gcm.message_id"
//        static let customURLScheme = "kingguests"

        
        
        struct SocialMediaLinks {
            
//            //twitter://user?screen_name=\(screenName)
//
//            //instagram://user?screen_name=\(screenName)
//
//            //facebook://user?screen_name=\(screenName)
            
              static let facebookWeb = "https://www.facebook.com/KingGuestsHaj"
              static let twitterWeb = "https://twitter.com/KingGuests/"
              static let instagramWeb = "https://www.instagram.com/kingguests"
              static let youtubeWeb = "https://www.youtube.com/user/GuestsKSA"
              static let facebookApp = "fb://profile/1539707949662892"//KingGuestsHaj//
              static let twitterApp = "twitter://user?screen_name=KingGuests"
              static let instagramApp = "instagram://user?username=kingguests" //https://www.instagram.com/developer/mobile-sharing/iphone-hooks/
              static let youtubeApp = "youtube://user/GuestsKSA"


        }
    }
}
