//
//  FirebaseManger.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//


import FirebaseMessaging

struct FirebaseMessagingManger {
    
    static var firebaseMessagingToken: String {
         return Messaging.messaging().fcmToken ?? "Not Available"
    }
    
}
