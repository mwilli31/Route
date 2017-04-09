//
//  AccessContactsViewController.swift
//  Route
//
//  Created by Michael Williams on 12/23/15.
//  Copyright © 2015 Michael Williams. All rights reserved.
//

import UIKit
import Contacts

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
//                if let data = UserDefaults.standard.object(forKey: "CurrentUser") as? NSData {
//                    
//                    //let currentUser = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! CurrentUser
//                    
//                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
//                    
//                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//                    
//                    var results: [CNContact] = []
//                    
//                    do{
//                        try self.contactStore.enumerateContacts(with: request) {
//                            contact, stop in
//                            results.append(contact)
//                        }
//                    } catch let err{
//                        print(err)
//                    }
                
                    
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
                    
//                    let phoneUtil = NBPhoneNumberUtil()
//                    
//                    var contactsWithRoute: [String] = []
//                    
//                    for contact in results {
//                        for (index, item) in contact.phoneNumbers.enumerate() {
//                            let pn: CNPhoneNumber = item.value as! CNPhoneNumber
//                            
//                            do {
//                                //format all numbers into the same format for storage (e 164 international format)
//                                let countryCode = pn.valueForKey("countryCode") as! String
//                                let digits = pn.valueForKey("digits") as! String
//                                
//                                let phoneNumber: NBPhoneNumber = try phoneUtil.parse(digits, defaultRegion: countryCode)
//                                let formattedNumber: String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
//                                
//                                //let match = 
//                                self.doesPhoneNumberMatchExistingRouteUser(formattedNumber, uid: currentUser.authorizationData)
//                                
//                                //if(match != "") {
//                                //    contactsWithRoute.append(match)
//                                //}
//                            }
//                            catch let error as NSError {
//                                print(error.localizedDescription)
//                            }
//                            
//                        }
//                        print("")
//                    }
//                    
//                    print(contactsWithRoute)
//                    
//                    self.performSegueWithIdentifier("SuccessView", sender: sender)
                    
//                }
            }
        }
    }
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        print("denied")
                    }

                }
            })
            
        default:
            completionHandler(false)
        }
    }
    
    func doesPhoneNumberMatchExistingRouteUser(phonenumber: String, uid: String) {
//        let myFirebase = Firebase(url:"https://routeapp.firebaseio.com")
//        
//        //let semaphore = dispatch_semaphore_create(0) // 1
//        
//        let usersPNRef = myFirebase.childByAppendingPath("RouteUsersPN").childByAppendingPath(phonenumber)
//        
//        usersPNRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            if snapshot.value is NSNull {
//                //give a reference to the Route uid of the friend who has the contact (which is the device owner)
//                let nonUsersPNRef = myFirebase.childByAppendingPath("NonRouteUsers").childByAppendingPath(phonenumber).childByAppendingPath(uid)
//                nonUsersPNRef.childByAppendingPath(uid).setValue(true, withCompletionBlock: {
//                    (error:NSError?, ref:Firebase!) in
//                    if (error != nil) {
//                        print(error)
//                        //dispatch_semaphore_signal(semaphore) // 2
//                    } else {
//                        print("Data saved successfully!")
//                        //dispatch_semaphore_signal(semaphore) // 2
//                    }
//                })
//                
//            } else {
//                //We know this Route user exists
//                let match = snapshot.value
//                print(match)
//                //dispatch_semaphore_signal(semaphore) // 2
//            }
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
//        
//        //let timeout = dispatch_time(DISPATCH_TIME_NOW, 10000000000)
//       /* if dispatch_semaphore_wait(semaphore, timeout) != 0 { // 3
//            print("taking too long to retreive...Failing")
//        } */
//        
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
