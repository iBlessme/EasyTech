//
//  Message.swift
//  EasyTech
//
//  Created by iBlessme on 23.02.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Hashable{
    let id: String
    let fromID, text, timStamp, toId : String
    
}

struct RecentMessage: Codable, Hashable, Identifiable{
    @DocumentID var id: String?
    let text: String
    let fromId, toId: String
    let timestamp: Date
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
