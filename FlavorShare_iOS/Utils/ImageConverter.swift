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
     - parameter targetSize: The target size to resize the image to (default keeps the original size).
     - parameter quality: The quality of the resulting HEIF image, ranging from 0.0 to 1.0 (default is 0.7 for compression).
     - returns: Compressed and resized HEIF image data or nil if unsuccessful.
     */
    func convertUIImageToHEIF(image: UIImage, targetSize: CGSize? = nil, quality: CGFloat = 0.7) -> Data? {
        var resizedImage = image
        
        // Resize image if targetSize is provided
        if let targetSize = targetSize {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            resizedImage = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        }
        
        guard let cgImage = resizedImage.cgImage else { return nil }
        
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, UTType.heic.identifier as CFString, 1, nil) else {
            print("Failed to create CGImageDestination for HEIF")
            return nil
        }
        
        // Set image compression quality (0.0 is max compression, 1.0 is no compression)
        let options: [NSString: Any] = [kCGImageDestinationLossyCompressionQuality: quality]
        
        // Add image to destination with options for compression
        CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
        
        if CGImageDestinationFinalize(destination) {
            return data as Data
        } else {
            print("Failed to finalize HEIF image destination")
            return nil
        }
    }


}
