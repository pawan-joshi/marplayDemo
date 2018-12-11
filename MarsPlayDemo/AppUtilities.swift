//
//  AppUtilities.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import UIKit

class AppUtilities: NSObject {
    public override init() {
        super.init()
    }

    class func showLoaderWithText(text: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if UIApplication.shared.isIgnoringInteractionEvents == false {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        SVProgressHUD.show(withStatus: text)
    }

    class func setLoaderText(text: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.setStatus(text)
        if UIApplication.shared.isIgnoringInteractionEvents == false {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    class func configureLoader() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
    }

    class func showLoader() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if UIApplication.shared.isIgnoringInteractionEvents == false {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        SVProgressHUD.show()
        // SwiftSpinner.show("Processing, please wait...")

        // let activityData = ActivityData()
        // activityData.type = NVActivityIndicatorType.lineScale
        // NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    class func hideLoader() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.dismiss()
    }

}
