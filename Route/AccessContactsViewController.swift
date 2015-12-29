//
//  AccessContactsViewController.swift
//  Route
//
//  Created by Michael Williams on 12/23/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Contacts
import UIAlertControllerExtension
import PermissionScope

class AccessContactsViewController: UIViewController {
    
    let pscope = PermissionScope()
    var contactStore = CNContactStore()
    @IBOutlet var useAddressBookButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useAddressBook(sender: AnyObject) {
        requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                
                // Get all the containers
                var allContainers: [CNContainer] = []
                do {
                    allContainers = try self.contactStore.containersMatchingPredicate(nil)
                } catch {
                    print("Error fetching containers")
                }
                
                var results: [CNContact] = []
                
                // Iterate all containers and append their contacts to our results array
                for container in allContainers {
                    let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
                    
                    do {
                        let containerResults = try self.contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keys)
                        results.appendContentsOf(containerResults)
                    } catch {
                        print("Error fetching results for container")
                    }
                }
                
                print(results)
                self.performSegueWithIdentifier("SuccessView", sender: sender)
                
            }
        }
    }
    
    func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
            
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(accessGranted: access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        print("denied")
                    }

                }
            })
            
        default:
            completionHandler(accessGranted: false)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
