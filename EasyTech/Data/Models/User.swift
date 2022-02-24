//
//  User.swift
//  EasyTech
//
//  Created by iBlessme on 07.02.2022.
//

import Foundation
import UIKit

struct User: Identifiable, Codable, Hashable{
//    var uid: String
    let id, email, name, surname, numberPhone, imageUrl : String
    let permission: String
}

