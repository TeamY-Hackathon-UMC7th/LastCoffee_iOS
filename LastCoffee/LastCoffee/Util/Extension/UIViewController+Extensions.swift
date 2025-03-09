//
//  UIViewController+Extensions.swift
//  LastCoffee
//
//  Created by 김도연 on 3/9/25.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

extension UIViewController {
    private struct LoadingIndicator {
        static var activityIndicator: NVActivityIndicatorView?
    }
    
    /// viewWillAppear에서 호출(로딩인디케이터 기본 세팅)
    func setupLoadingIndicator() {
        guard LoadingIndicator.activityIndicator == nil else { return } // 중복 추가 방지
        
        let indicator = NVActivityIndicatorView(
            frame: .zero,
            type: .circleStrokeSpin,
            color: .black,
            padding: 50
        )
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        LoadingIndicator.activityIndicator = indicator
    }
    
    /// API 호출 코드 실행 전 호출
    func startLoading() {
        DispatchQueue.main.async {
            self.setupLoadingIndicator()
            LoadingIndicator.activityIndicator?.startAnimating()
        }
    }
    
    /// API 호출 후(성공/실패 분기 모두에서) UI 업데이트 진행 전 호출
    func stopLoading() {
        DispatchQueue.main.async {
            LoadingIndicator.activityIndicator?.stopAnimating()
            LoadingIndicator.activityIndicator?.removeFromSuperview()
            LoadingIndicator.activityIndicator = nil
        }
    }
}
