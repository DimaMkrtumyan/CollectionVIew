//
//  UIImage + Extension.swift
//  CollectionView_Practice
//
//  Created by Dmitriy Mkrtumyan on 08.08.23.
//

import UIKit

extension UIImage {
    func sizeToFillWidth(of size: CGSize, image: UIImage) -> CGSize {

      let imageSize = image.size
      var returnSize = size

      let aspectRatio = imageSize.width / imageSize.height

      returnSize.height = returnSize.width / aspectRatio

      if returnSize.height > size.height {
        returnSize.height = size.height
        returnSize.width = size.height * aspectRatio
      }

      return returnSize
    }
}
