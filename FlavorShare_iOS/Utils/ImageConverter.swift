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
     This function is used to convert UIImage to webP format allowing smaller image size. This function is using SDWebImage library. and the conversion is very slow.
     - parameter image: Image to convert
     - returns: Converted webp image OR nil if unsuccessful.
     */
    func convertUIImageToWebp(image: UIImage) -> Data? {
        return image.sd_imageData(as: .webP)
    }
    
    // MARK: - convertUIImageToHEIF()
    /**
     This function is used to resize and convert UIImage to HEIF format with optional quality adjustment for smaller image size.
     - parameter image: Image to convert.
     - parameter targetSize: The target size to resize the image to,  ranging from 0.0 to 1.0 (default is 0.5 for compression).
     - parameter quality: The quality of the resulting HEIF image, ranging from 0.0 to 1.0 (default is 0.7 for compression).
     - returns: Compressed and resized HEIF image data or nil if unsuccessful.
     */
    func convertUIImageToHEIF(image: UIImage, targetScaleFactor: CGFloat? = 0.5, quality: CGFloat = 0.7) -> Data? {
        // Determine the new size based on the target scale factor, if provided
        var size = image.size
        if let scaleFactor = targetScaleFactor {
            size = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        }
        
        // Resize the image to the new size
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: .zero, size: size))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        
        // Ensure the image can be converted to a CGImage
        guard let cgImage = resizedImage.cgImage else { return nil }
        
        // Prepare HEIF image destination
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, UTType.heic.identifier as CFString, 1, nil) else {
            print("func convertUIImageToHEIF() - Failed to create CGImageDestination for HEIF")
            return nil
        }
        
        // Set compression options
        let options: [NSString: Any] = [kCGImageDestinationLossyCompressionQuality: quality]
        
        // Add the image to the destination
        CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
        
        // Finalize the destination and return the compressed data
        if CGImageDestinationFinalize(destination) {
            return data as Data
        } else {
            print("func convertUIImageToHEIF() - Failed to finalize HEIF image destination")
            return nil
        }
    }

    
}
