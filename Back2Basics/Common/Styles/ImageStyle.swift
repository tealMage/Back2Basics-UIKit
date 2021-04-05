//
//  ImageStyle.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import Foundation
import UIKit

enum ImageType: Int, CaseIterable {
    case arrowBack
    case closeButton

    func imageName() -> String {
        var imageName = ""
        
        switch self {
        
        case .arrowBack:
            imageName = "Icon-Back"

        case .closeButton:
            imageName = "Icon-Close"
            
        }
        
        return imageName
    }
    
    func image() -> UIImage {
        let imageName = self.imageName()

        return UIImage(named: imageName) ?? UIImage()
    }
    
    func tintableImage() -> UIImage {
        return self.image().withRenderingMode(.alwaysTemplate)
    }

}
