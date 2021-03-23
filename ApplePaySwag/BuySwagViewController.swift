//
//  DetailViewController.swift
//  ApplePaySwag
//
//  Created by Erik.Kerber on 10/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import PassKit

class BuySwagViewController: UIViewController {
    
    @IBOutlet weak var swagPriceLabel: UILabel!
    @IBOutlet weak var swagTitleLabel: UILabel!
    @IBOutlet weak var swagImage: UIImageView!
    @IBOutlet weak var applePayButton: UIButton!
    
    let supportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.discover]
    
    var swag: Swag? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        
        if (!self.isViewLoaded) {
            return
        }
        
        self.title = swag?.title
        self.swagPriceLabel.text = "$" + (swag?.priceString ?? "0")
        self.swagImage.image = swag?.image
        self.swagTitleLabel.text = swag?.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        //applePayButton.isHidden = !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedPaymentNetworks)
    }
    
    @IBAction func purchase(sender: UIButton) {
        let request = PKPaymentRequest()
        let applePaySwagMerchantID = "merchant.sure.com" // Fill in your merchant ID here!
        request.merchantIdentifier = applePaySwagMerchantID
        request.supportedNetworks = supportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.capabilityCredit
        request.countryCode = "US"
        request.currencyCode = "USD"
        let paymentSummaryItems: [PKPaymentSummaryItem] = [
            PKPaymentSummaryItem(label: swag?.title ?? "", amount: swag?.price ?? 0.0),
            PKPaymentSummaryItem(label: "Razeware", amount: swag?.price ?? 0.0)
        ]
        request.paymentSummaryItems = paymentSummaryItems
        
        guard let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request) else { return }
        applePayController.delegate = self
        self.present(applePayController, animated: true, completion: nil)
    }
}

extension BuySwagViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) {
        
        let token = payment.token
        let contact = payment.billingContact
        completion(.success)
        
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
