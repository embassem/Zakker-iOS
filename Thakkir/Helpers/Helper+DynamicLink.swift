//
//  Helper+DynamicLink.swift
//  Guest-iOS
//
//  Created by Bassem on 2/4/18.
//  Copyright © 2018 Ibtikar. All rights reserved.
//

import Foundation
import FirebaseDynamicLinks

extension Helper {
    
    class DynamicLink {
        
        static let DYNAMIC_LINK_DOMAIN = "q376h.app.goo.gl"
         static let packageName = "sa.gov.kingguests"
        
        class func buildFDLLink(linkString:String , title:String ,descriptionText:String?, image:String , delegate:@escaping ((URL)->Void)){         
                guard let link = URL(string: linkString) else {  return }
                let components = DynamicLinkComponents(link: link, domain: self.DYNAMIC_LINK_DOMAIN)
                
//                // analytics params
//                let analyticsParams = DynamicLinkGoogleAnalyticsParameters(
//                    source:  "",
//                    medium:  "",
//                    campaign:  "")
//                analyticsParams.term = ""
//                analyticsParams.content = ""
//                components.analyticsParameters = analyticsParams
//
//                if let bundleID = dictionary[.bundleID]?.text {
//                    // iOS params
//                    let iOSParams = DynamicLinkIOSParameters(bundleID: bundleID)
//                    iOSParams.fallbackURL = dictionary[.fallbackURL]?.text.flatMap(URL.init)
//                    iOSParams.minimumAppVersion = dictionary[.minimumAppVersion]?.text
//                    iOSParams.customScheme = dictionary[.customScheme]?.text
//                    iOSParams.iPadBundleID = dictionary[.iPadBundleID]?.text
//                    iOSParams.iPadFallbackURL = dictionary[.iPadFallbackURL]?.text.flatMap(URL.init)
//                    iOSParams.appStoreID = dictionary[.appStoreID]?.text
//                    components.iOSParameters = iOSParams
//
//                    // iTunesConnect params
//                    let appStoreParams = DynamicLinkItunesConnectAnalyticsParameters()
//                    appStoreParams.affiliateToken = dictionary[.affiliateToken]?.text
//                    appStoreParams.campaignToken = dictionary[.campaignToken]?.text
//                    appStoreParams.providerToken = dictionary[.providerToken]?.text
//                    components.iTunesConnectParameters = appStoreParams
//                }
//
            
                    // Android params
                    let androidParams = DynamicLinkAndroidParameters(packageName: packageName)
                    androidParams.fallbackURL = link
//                    androidParams.minimumVersion = 18
                    components.androidParameters = androidParams

//
            
            
//                // social tag params
                let socialParams = DynamicLinkSocialMetaTagParameters()
                socialParams.title = title
                socialParams.descriptionText = descriptionText
                if let imageURl = URL(string:image) {
                    socialParams.imageURL = imageURl
                }
//                assert( socialParams.imageURL == nil, "image url is not valid")
                components.socialMetaTagParameters = socialParams
//
//                // OtherPlatform params
                let otherPlatformParams = DynamicLinkOtherPlatformParameters()
                otherPlatformParams.fallbackUrl = link
                components.otherPlatformParameters = otherPlatformParams
//
                var longLink = components.url
                print(longLink?.absoluteString ?? "")

                
            
            //return longLink

                let options = DynamicLinkComponentsOptions()
                options.pathLength = .short
            
                components.options = options

                components.shorten { (shortURL, warnings, error) in

                    if let error = error {
                        print(error.localizedDescription)

                    }
                    var shortLink = shortURL
                    print(shortLink?.absoluteString ?? "")
                    if let shortURL = shortURL {
                    delegate(shortURL)
                    }

                }

            }
        
        enum Params: String {
            case link = "Link Value"
            case source = "Source"
            case medium = "Medium"
            case campaign = "Campaign"
            case term = "Term"
            case content = "Content"
            case bundleID = "App Bundle ID"
            case fallbackURL = "Fallback URL"
            case minimumAppVersion = "Minimum App Version"
            case customScheme = "Custom Scheme"
            case iPadBundleID = "iPad Bundle ID"
            case iPadFallbackURL = "iPad Fallback URL"
            case appStoreID = "AppStore ID"
            case affiliateToken = "Affiliate Token"
            case campaignToken = "Campaign Token"
            case providerToken = "Provider Token"
            case packageName = "Package Name"
            case androidFallbackURL = "Android Fallback URL"
            case minimumVersion = "Minimum Version"
            case title = "Title"
            case descriptionText = "Description Text"
            case imageURL = "Image URL"
            case otherFallbackURL = "Other Platform Fallback URL"
        }
        
        enum ParamTypes: String {
            case googleAnalytics = "Google Analytics"
            case iOS = "iOS"
            case iTunes = "iTunes Connect Analytics"
            case android = "Android"
            case social = "Social Meta Tag"
            case other = "Other Platform"
        }
    }
    
}
