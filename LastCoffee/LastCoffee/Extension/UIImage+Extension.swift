//
//  UIImage+Extension.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit

extension UIImage {
    public func resize(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
