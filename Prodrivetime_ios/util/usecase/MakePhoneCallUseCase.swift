//
//  MakePhoneCallUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/7/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

class MakePhoneCallUseCase {
    
    static func makeCallUrl(number: String) -> URL? {
        guard let url = URL(string: "tel://\(number)") else { return nil}
        return url
    }
}

// https://stackoverflow.com/questions/40078370/how-to-make-phone-call-in-ios-10-using-swift
//
//You can call like this:
//
// if let url = URL(string: "tel://\(number)") {
//                UIApplication.shared.openURL(url)
//            }
//For Swift 3+, you can use like
//
//guard let number = URL(string: "tel://" + number) else { return }
//UIApplication.shared.open(number)
//
//OR
//
//UIApplication.shared.open(number, options: [:], completionHandler: nil)
//Make sure you've scrubbed your phone number string to remove any instances of (, ), -, or space.
