//
//  NoInternetConnectionPopup.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

public final class MessagePopup: UIViewController {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = CUI.themeTextColor
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(CUI.themeTextColor, for: .normal)
        button.setTitle("OK", for: .normal)

        return button
    }()


    public convenience init(with message: String) {
        self.init(nibName: nil, bundle: nil)

        messageLabel.text = message
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CUI.themeColor
        view.backgroundColor = CUI.themeColor
        
        view.addSubviews(messageLabel, okButton)
        okButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc
    private func dismissPopup() {
        dismiss(animated: true)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        messageLabel.pin
            .horizontally(32)
            .vCenter()
            .sizeToFit(.width)

        okButton.pin
            .bottom(view.pin.safeArea)
            .marginBottom(22)
            .hCenter()
            .size(40)
    }
}
