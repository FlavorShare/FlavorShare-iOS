//
//  UserListConfig.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-14.
//

import Foundation

enum UserListConfig {
    case followers(uid: String)
    case following(uid: String)
    case likes(postId: String)
    case explore
}
