//
//  FilterService.swift
//  CameraApp
//
//  Created by Suhyoung Eo on 2022/01/15.
//

import UIKit
import RxSwift

class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage) { image in
                observer.onNext(image)
            }
            
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping (UIImage) -> Void) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let outputImage = filter.outputImage {
                
                if let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent) {
                    
                    let processingImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                    completion(processingImage)
                }
            }
        }
    }
    
}
