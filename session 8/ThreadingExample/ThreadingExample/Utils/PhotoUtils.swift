//
//  PhotoUtils.swift
//  ThreadingExample
//
//  Created by Rasko Gojkovic on 2/28/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation
import UIKit




class ImageProcessor {
    
    var imageView: UIImageView?
    private (set) var width : Int
    private (set) var height : Int
    private (set) var pixels : [UInt8]?
    

    static let redChannel :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        return (r, 0, 0)
    }

    static let greenChannel :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        return (0, g, 0)
    }

    static let blueChannel :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        return (0, 0, b)
    }

    static let gray :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        let sum : UInt = UInt(r) + UInt(g) + UInt(b)
        let avg = UInt8(sum/3);
        return (avg, avg, avg)
    }
    
    static let accentRed :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        if UInt(r) > UInt(g)+UInt(b) {
            return (r, g, b)
        } else {
            return ImageProcessor.gray(r, g, b)
        }
    }

    static let accentGreen :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        if UInt(g) > UInt(r)+UInt(b) {
            return (r, g, b)
        } else {
            return ImageProcessor.gray(r, g, b)
        }
    }

    static let accentBlue :( UInt8, UInt8, UInt8)->(r: UInt8, g: UInt8, b: UInt8) = {r, g, b in
        if UInt(b) > UInt(g)+UInt(r) {
            return (r, g, b)
        } else {
            return ImageProcessor.gray(r, g, b)
        }
    }

    
    
    
    
    
    
    
    
    init(image: UIImage?, imageView: UIImageView?) {
        self.imageView = imageView
        (pixels, width, height) = ImageProcessor.pixelData(fromUIImage: image)
    }
    
    
    func processImage(andUpdateView shouldUpdate : Bool = true, pixelTransform: (_ r: UInt8, _ g: UInt8, _ b: UInt8)->(r: UInt8, g: UInt8, b: UInt8)){
        
        
        
        if var pixels = self.pixels {
            
            var (newR, newG, newB) : (UInt8, UInt8, UInt8)
            var rPosition : Int
            for col in 0..<width {
                for row in 0..<height{
                    
                    rPosition = Int(row * width*4 + col*4)
                    
                    (newR, newG, newB) = pixelTransform(
                        pixels[rPosition + 0],
                        pixels[rPosition + 1],
                        pixels[rPosition + 2])
                    
                    pixels[rPosition + 0] = newR
                    pixels[rPosition + 1] = newG
                    pixels[rPosition + 2] = newB
                    
                    if row % 4 == 0 {
                        
                        let transformedImage = self.uiImage32(fromPixelValues: pixels, width: width, height: height)
                        if shouldUpdate {
                            DispatchQueue.main.async {
                                self.imageView?.image = transformedImage;
                            }
                        }
                    }
                }
            }
            
            if shouldUpdate {
                DispatchQueue.main.async {
                    let transformedImage = self.uiImage32(fromPixelValues: pixels, width: self.width, height: self.height)
                    self.imageView?.image = transformedImage;
                }
                
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static func pixelValues(fromUIImage uiImage: UIImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int){
        var cgImage: CGImage? = nil;
        
        if let image = uiImage {
            cgImage = image.cgImage
        }
        
        return pixelValues(fromCGImage: cgImage);
    }
    
    func uiImage32(fromPixelValues pixelValues: [UInt8]?, width: Int, height: Int) -> UIImage?{
        
        if let imageRef = cgImage32(fromPixelValues: pixelValues, width: width, height: height){
            return UIImage(cgImage: imageRef);
        }
        return nil;
    }
    
    static func pixelValues(fromCGImage imageRef: CGImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int)
    {
        var width = 0
        var height = 0
        var pixelValues: [UInt8]?
        if let imageRef = imageRef {
            
            let cpImage = imageRef.copy(colorSpace: CGColorSpaceCreateDeviceRGB())!
            
            width = cpImage.width
            height = cpImage.height
            let bitsPerComponent = cpImage.bitsPerComponent
            let bytesPerRow = cpImage.bytesPerRow
            let totalBytes = height * bytesPerRow
            
            
            
            let colorSpace = cpImage.colorSpace!
            var intensities = [UInt8](repeating: 0, count: totalBytes)
            
            let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
            contextRef?.draw(cpImage, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
            
            pixelValues = intensities
        }
        
        return (pixelValues, width, height)
    }
    
    
    static func pixelData(fromUIImage uiImage: UIImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int) {
        
        if let img = uiImage{
            let size = img.size
            let dataSize = size.width * size.height * 4
            var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: &pixelData,
                                    width: Int(size.width),
                                    height: Int(size.height),
                                    bitsPerComponent: 8,
                                    bytesPerRow: 4 * Int(size.width),
                                    space: colorSpace,
                                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
            guard let cgImage = img.cgImage else { return (nil, 0, 0) }
            context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            //        return pixelData
            return (pixelData, Int(size.width), Int(size.height))
        }
        
        return (nil, 0, 0)
    }
    
    
    func cgImage32(fromPixelValues pixelValues: [UInt8]?, width: Int, height: Int) -> CGImage?
    {
        var imageRef: CGImage?
        if var pixelValues = pixelValues {
            let bitsPerComponent = 8
            let bytesPerPixel = 4
            let bitsPerPixel = bytesPerPixel * bitsPerComponent
            let bytesPerRow = bytesPerPixel * width
            let totalBytes = height * bytesPerRow
            
            imageRef = withUnsafePointer(to: &pixelValues, {
                ptr -> CGImage? in
                var imageRef: CGImage?
                let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
                
                let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue).union(CGBitmapInfo())
                let data = UnsafeRawPointer(ptr.pointee).assumingMemoryBound(to: UInt8.self)
                let releaseData: CGDataProviderReleaseDataCallback = {
                    (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
                }
                
                if let providerRef = CGDataProvider(dataInfo: nil, data: data, size: totalBytes, releaseData: releaseData) {
                    imageRef = CGImage(width: width,
                                       height: height,
                                       bitsPerComponent: bitsPerComponent,
                                       bitsPerPixel: bitsPerPixel,
                                       bytesPerRow: bytesPerRow,
                                       space: colorSpaceRef,
                                       bitmapInfo: bitmapInfo,
                                       provider: providerRef,
                                       decode: nil,
                                       shouldInterpolate: false,
                                       intent: CGColorRenderingIntent.defaultIntent)
                }
                
                return imageRef
            })
        }
        
        return imageRef
    }

    
    
}







