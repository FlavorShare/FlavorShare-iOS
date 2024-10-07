//
//  ImageUploadService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-18.
//

import Foundation
import AWSCore
import AWSS3

class ImageStorageService {
    static let shared = ImageStorageService()
    
    private let accessKey: String
    private let secretKey: String
    private let bucketName: String
    private let endpoint: String
    private let token: String
    
    private init() {
        self.accessKey = EnvironmentVariables.doAccessKey
        self.secretKey = EnvironmentVariables.doSecretKey
        self.bucketName = EnvironmentVariables.doBucketName
        self.endpoint = EnvironmentVariables.doEndPoint
        self.token = EnvironmentVariables.doToken
        
        // Configure AWS with custom endpoint for DigitalOcean
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let endpointUrl = URL(string: endpoint)!
        let customEndpoint = AWSEndpoint(region: .USEast1, service: .S3, url: endpointUrl)
        
        let configuration = AWSServiceConfiguration(
            region: .USEast1,
            endpoint: customEndpoint,
            credentialsProvider: credentialsProvider
        )
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Enable HTTP debugging for verbose logging
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance!)
    }
    
    // MARK: - uploadImage()
    /**
     This function is used to POST/PUT image to DigitalOcean S3 Storage
     - parameter data: Image data in heif format
     - parameter fileName: File name in format \*.heif
     - returns: String containing error if process failed
     */
    func uploadImage(data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        let transferUtility = AWSS3TransferUtility.default()
        print("Uploading image to DigitalOcean S3 Storage")
        
        transferUtility.uploadData(
            data,
            bucket: bucketName,
            key: fileName,
            contentType: "image/heif",
            expression: nil
        ) { task, error in
            if let error = error {
                completion(.failure(error))
            } else if let _ = task.response {
                completion(.success("\(self.endpoint)/\(fileName)"))
            }
        }
    }
    
    // MARK: - downloadImage()
    /**
     This function is used to GET image ressource from DigitalOcean S3 Storage. Converts the data to return a UIImage
     - parameter fileName: File name in format \*.heif
     - returns: UIImage OR String containing error if process failed
     */
    func downloadImage(fileName: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let transferUtility = AWSS3TransferUtility.default()
        
        transferUtility.downloadData(
            fromBucket: bucketName,
            key: fileName,
            expression: nil
        ) { task, url, data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                let error = NSError(domain: "ImageStorageService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to download or decode image"])
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - deleteImage()
    /**
     This function is used to DELETE image ressource from DigitalOcean S3 Storage
     - parameter fileName: File name in format \*.heif
     - returns: String containing error if process failed
     */
    func deleteImage(fileName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let s3 = AWSS3.default()
        let deleteObjectRequest = AWSS3DeleteObjectRequest()!
        deleteObjectRequest.bucket = bucketName
        deleteObjectRequest.key = fileName
        
        s3.deleteObject(deleteObjectRequest).continueWith { task -> AnyObject? in
            if let error = task.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            return nil
        }
    }
}
