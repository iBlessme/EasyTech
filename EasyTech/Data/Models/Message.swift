//
//  Message.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import Foundation


struct Message: Codable, Hashable{
    let id: String
    let fromID, text, timStamp, toId : String
    
}
