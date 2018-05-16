//
//  Helper+Analytics.swift
//  Guest-iOS
//
//  Created by Bassem on 10/26/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation
import Fabric
import FirebaseAnalytics
import Crashlytics

extension Helper {
    
    public  class Analytics {
        public enum ContentViewName:String {
            
            
            case aboutViewController = "AboutView"
            case aboutProgramDetailsViewController = "AboutProgramDetailsView"
            case contactUsDetailsViewController = "ContactUsDetailsView"
            case contactUsListViewController = "ContactUsListView"
            case newsViewController = "NewsListView"
            case newsDetailsViewController = "NewsDetailsView"
            case photosViewController = "PhotosListView"
            case videoPlayerViewController = "videoPlayerView"
            case videosViewController = "VideosListView"
            case notificationDetailsViewController = "NotificationDetailsView"
            case notificationsListViewController = "NotificationsList"
            case prayerTimesViewController = "PrayerTimesView"
            case ProfileViewController = "ProfileView"
            case QiblaViewController = "QiblaView"
            case SendContactUsViewController = "SendContactUsView"
            case surveyViewController = "SurveyView"
            case settingsViewController = "SettingsView"
            case timelineViewController = "TimelineView"
            case timelineDetailsViewController = "TimelineDetailsView"
            case updateProfileViewController = "UpdateProfileView"
            case magazineDetailsViewController = "MagazineDetailsView"
            case magazineViewController = "MagazineView"
            case magazinePDFViewController = "MagazinePDFView"
        }
        public class func contentView(name:ContentViewName,contentType: String? = nil, contentId: String? = nil, customAttributes: [String : Any]? = nil) {
            
            
            // Swift
            Answers.logContentView(withName: name.rawValue, contentType: contentType, contentId: contentId, customAttributes: customAttributes);
            
           
            
        }
        
        
        
        
        
    }
    
    
    
}
