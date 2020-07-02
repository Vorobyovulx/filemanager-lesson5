//
//  Session.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 05/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

class Session {
    private init() { }
    
    public static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
    var nextFrom: String = ""
}
