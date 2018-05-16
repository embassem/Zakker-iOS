//
//  Helper+Images.swift
//  Guest-iOS
//
//  Created by Bassem on 2/25/18.
//  Copyright © 2018 Ibtikar. All rights reserved.
//

import Nuke


extension Helper {
    class Images
    {
        
        static var nukePhotoManager : Nuke.Manager = {
            var instance = Nuke.Manager.shared;
            return instance
        }()
        
    }
    
}
