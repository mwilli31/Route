//
//  Network.swift
//  wifi
//
//  Created by Michael Williams on 4/2/17.
//  Copyright © 2017 Route. All rights reserved.
//

struct Network {
    enum State: String {
        case Active, Error, Busy
    }
    
    let name: String
    let usersActive: Int
    let usersAllowed: Int
    let state: State
    
}
