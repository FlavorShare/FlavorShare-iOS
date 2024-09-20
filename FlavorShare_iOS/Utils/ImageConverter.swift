//
//  UIImageWebpConverter.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-18.
//

import Foundation
import SDWebImage
import SDWebImageWebPCoder
import CoreImage
import ImageIO
import UniformTypeIdentifiers

class ImageConverter {
    
    static let shared = ImageConverter()
    
    private init() {
        // Register WebP coder
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
    }
    
    // MARK: - convertUIImageToWebp()
    /**
     This function is used to convert UIImage to webP format allowing smaller image size.
     - parameter image: Image to convert
     - returns: Converted webp image OR nil if unsuccessful.
     */
    func convertUIImageToWebp(image: UIImage) -> Data? {
        return image.sd_imageData(as: .webP)
    }
    
    // MARK: - convertUIImageToHEIF()
    /**
     This function is used to convert UIImage to HEIF format allowing smaller image size.
     - parameter image: Image to convert
     - returns: Converted HEIF image OR nil if unsuccessful.
     */
    func convertUIImageToHEIF(image: UIImage) -> Data? {
        guard let cgImage = image.cgImage else { return nil }
        
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, UTType.heic.identifier as CFString, 1, nil) else {
            print("Failed to create CGImageDestination for HEIF")
            return nil
        }
        
        CGImageDestinationAddImage(destination, cgImage, nil)
        
        if CGImageDestinationFinalize(destination) {
            return data as Data
        } else {
            print("Failed to finalize HEIF image destination")
            return nil
        }
    }
}
