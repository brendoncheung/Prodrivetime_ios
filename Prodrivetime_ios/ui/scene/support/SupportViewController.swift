//
//  SupportViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class SupportViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: "Support", image: UIImage(named: "support_tab"), tag: 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log.debug(self)
    }
    
    @IBAction func onSubmitButtonTapped(_ sender: Any) {
        log.debug("submit button tapped")
        self.dismiss(animated: true, completion: nil)
    }
}

extension SupportViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
        
    }
    
    
}
