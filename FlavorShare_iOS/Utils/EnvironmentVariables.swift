//
//  Environment.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-19.
//

import Foundation

public struct EnvironmentVariables {
    
//    static let APIBaseURL = "https://flavorshare-backend.onrender.com"
    static let APIBaseURL = "http://localhost:3000"

    enum Keys {
        static let appAPIKey = "APP_API_Key"
        static let appAPISecret = "APP_API_Secret"
        
        static let doAccessKey = "DO_ACCESS_KEY"
        static let doSecretKey = "DO_SECRET_KEY"
        static let doBucketName = "DO_BUCKETNAME"
        static let doRegion = "DO_REGION"
        static let doEndPoint = "DO_ENDPOINT"
        static let doToken = "DO_TOKEN"
    }
    
    // Get the APP_API_Key
    static let appAPIKey: String = {
        guard let appAPIKeyProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.appAPIKey
        ) as? String else {
            fatalError("APP_API_Key not found in Info.plist")
        }
        return appAPIKeyProperty
    }()
    
    // Get the APP_API_Secret
    static let appAPISecret: String = {
        guard let appAPISecretProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.appAPISecret
        ) as? String else {
            fatalError("APP_API_Secret not found in Info.plist")
        }
        return appAPISecretProperty
    }()
    
    // Get the DO_ACCESS_KEY
    static let doAccessKey: String = {
        guard let doAccessKeyProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doAccessKey
        ) as? String else {
            fatalError("DO_ACCESS_KEY not found in Info.plist")
        }
        return doAccessKeyProperty
    }()
    
    // Get the DO_SECRET_KEY
    static let doSecretKey: String = {
        guard let doSecretKeyProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doSecretKey
        ) as? String else {
            fatalError("DO_SECRET_KEY not found in Info.plist")
        }
        return doSecretKeyProperty
    }()
    
    // Get the DO_BUCKETNAME
    static let doBucketName: String = {
        guard let doBucketNameProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doBucketName
        ) as? String else {
            fatalError("DO_BUCKETNAME not found in Info.plist")
        }
        return doBucketNameProperty
    }()
    
    // Get the DO_REGION
    static let doRegion: String = {
        guard let doRegionProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doRegion
        ) as? String else {
            fatalError("DO_REGION not found in Info.plist")
        }
        return doRegionProperty
    }()
    
    // Get the DO_ENDPOINT
    static let doEndPoint: String = {
        guard let doEndPointProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doEndPoint
        ) as? String else {
            fatalError("DO_ENDPOINT not found in Info.plist")
        }
        return doEndPointProperty
    }()
    
    // Get the DO_TOKEN
    static let doToken: String = {
        guard let doTokenProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.doToken
        ) as? String else {
            fatalError("DO_TOKEN not found in Info.plist")
        }
        return doTokenProperty
    }()
}
