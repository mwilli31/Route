//
//  AccessContactsViewController.swift
//  Route
//
//  Created by Michael Williams on 12/23/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Contacts
import libPhoneNumber_iOS

class AccessContactsViewController: UIViewController {
    
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
                
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                var results: [CNContact] = []
                
                do{
                    try self.contactStore.enumerateContactsWithFetchRequest(request) {
                        contact, stop in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers)
                        print("")
                        results.append(contact)
                    }
                } catch let err{
                    print(err)
                }
                
                
                // Get all the containers
               /* var allContainers: [CNContainer] = []
                do {
                    allContainers = try self.contactStore.containersMatchingPredicate(nil)
                } catch {
                    print("Error fetching containers")
                }
                
                
                // Iterate all containers and append their contacts to our results array
                for container in allContainers {
                    let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
                    
                    do {
                        let containerResults = try self.contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keys)
                        results.appendContentsOf(containerResults)
                    } catch {
                        print("Error fetching results for container")
                    }
                } */
                
                /*  Iterate through contacts results array and see if any of the contacts are Route Users:
                *       T. If users -> do they have Route Networks set up?
                *           T. If Route Network set up -> Display to user
                *       F. If NOT users -> is their phone number stored in ~/NonRouteUsers node?
                            T. If it doesn't exist -> Store in ~/NonRouteUsers
                */
                
                let phoneUtil = NBPhoneNumberUtil()

                for contact in results {
                    for (index, item) in contact.phoneNumbers.enumerate() {
                        let pn: CNPhoneNumber = item.value as! CNPhoneNumber
                        
                        do {
                            //format all numbers into the same format for storage (e 164 international format)
                            let countryCode = pn.valueForKey("countryCode") as! String
                            let digits = pn.valueForKey("digits") as! String
                            print(countryCode + "  " + digits)
                            
                            let phoneNumber: NBPhoneNumber = try phoneUtil.parse(digits, defaultRegion: countryCode)
                            let formattedString: String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
                            
                            print(formattedString)
                        }
                        catch let error as NSError {
                            print(error.localizedDescription)
                        }
                        
                    }
                    print("")
                }
                
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
