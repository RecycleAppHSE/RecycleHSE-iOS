//
//  AppHelper.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation
import UIKit

protocol URLOpener {
    func open(_ url: URL)
}

extension UIApplication: URLOpener {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}

protocol AppHelper {
    
    func sendEmail(to email: String?)
    func call(to phone: String?)
    func open(url: URL?)
}


struct AppHelperImp: AppHelper {
    
    let application: URLOpener
    
    func sendEmail(to email: String?) {
        guard let email = email else { return }
        guard let url = URL(string: "mailto:\(email)") else {
            return
        }
        application.open(url)
    }
    
    func call(to phone: String?) {
        guard let phone = phone else { return }
        guard let url = URL(string: "tel://" + phone) else { return }
        application.open(url)
    }
    
    func open(url: URL?) {
        guard let url = url else { return }
        application.open(url)
    }
    
}
