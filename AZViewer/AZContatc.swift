//
//  AZContatc.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/9/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation
import Contacts

public class AZContact: AZView{
    
    // MARK: Public
    
    
    // MARK: Private
    fileprivate let popup = AZPopupView()

    // MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    
    // default init
    fileprivate func defaultInit(){
        
        self.preparePopup()
    }
    
    // check permission
    public func checkPermission() -> [CNContact]{
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .denied || status == .restricted {
            self.popup.show()
            return []
        }
        
        // open it
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        
        return results
        
    }
    
    // show setting action button
    func settingButtonAction(_ sender: UIButton){
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            // Fallback on earlier versions
        }

    }
}

extension AZContact{
    
    // popup
    fileprivate func preparePopup(){
        
        self.popup.header.title = "دسترسی به مخاطبین"
        self.popup.alignment = .center
        
        // prepare label
        let label = AZLabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "این نرم افزار نیاز به دسترسی به مخاطبین دارد."
        label.font = AZStyle.shared.sectionHeaderTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        self.popup.view.addSubview(label)
        _ = label.aZConstraints.parent(parent: popup.view).top(constant: 8).right(constant: -8).left(constant: 8)
        
        // prepare button
        let settingButton: AZButton = AZButton()
        settingButton.titleLabel?.font = AZStyle.shared.sectionHeaderTitleFont
        settingButton.setTitle("برو به تنظیمات", for: .normal)
        settingButton.setBackground(color: AZStyle.shared.sectionHeaderBackgroundColor, forState: .normal)
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        self.popup.view.addSubview(settingButton)
        _ = settingButton.aZConstraints.parent(parent: popup.view).top(to: label, toAttribute: .bottom, constant: 8).left().right().height(constant: 35)
        settingButton.addTarget(self, action: #selector(settingButtonAction(_:)), for: .touchUpInside)
        _ = self.popup.view.aZConstraints.bottom(to: settingButton)
    }
}
