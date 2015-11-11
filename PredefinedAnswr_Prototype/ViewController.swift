//
//  ViewController.swift
//  CL_Prototype
//
//  Created by Daniel Robertson on 08/11/2015.
//  Copyright © 2015 Daniel Robertson. All rights reserved.
//

import UIKit; import CoreLocation; import SnapKit;

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    var questions = [Question]()
    var activeQuestion: Question!
    var questionIndex = 0
    
    var question1:Question!
    var question2:Question!
    var question3:Question!
    
    var name:String!
    var gender:String!
    var homeLocation:CLPlacemark?
    
    var input:UITextField!
    var output:UILabel!
    var inputBorder:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creates questions
        question1 = Question(title: "What's your name?", acceptedAnswers:[""])
        question2 = Question(title: "Hello, \(name), what's your gender?", acceptedAnswers: ["Male","Female","Boy","Girl"])
        question3 = Question(title: "Is your current location your home?", acceptedAnswers: ["Yes","No"])
        
        //Adds questions to questions array
        questions += [question1,question2,question3]
        
        
        //Sets default active question to Q1
        activeQuestion = questions[0]
        
        
        //Draw content+layout
        output = PaddedLabel(frame:CGRectMake(10, 270, screenWidth-20, 100))
        output.text = activeQuestion.title
        output.font = UIFont(name: "Menlo-Regular", size: 16)
        output.textColor = UIColor(red: 77/255, green: 192/255, blue: 86/255, alpha: 1.0)
        output.textAlignment = NSTextAlignment.Left
        output.numberOfLines = 0
        output.layer.borderColor = (UIColor.greenColor().CGColor)
        output.layer.borderWidth = 1.0
        view.addSubview(output)
        
        input = UITextField(frame: CGRectMake(10, 400, screenWidth-20, 40))
        input.attributedPlaceholder =  NSAttributedString(string: "Type shit here", attributes: [NSForegroundColorAttributeName:UIColor(red: 77/255, green: 192/255, blue: 86/255, alpha: 0.7)])
        input.font = UIFont(name: "Menlo-Regular", size: 16)
        input.textColor = UIColor(red: 77/255, green: 192/255, blue: 86/255, alpha: 1.0)
        input.textAlignment = NSTextAlignment.Left
        input.leftView = UIView(frame: CGRectMake(0, 0, 10, 40))
        input.leftViewMode = UITextFieldViewMode.Always
        input.autocapitalizationType = UITextAutocapitalizationType.Sentences
        input.keyboardAppearance = UIKeyboardAppearance.Dark
        input.layer.borderColor = (UIColor.greenColor().CGColor)
        input.layer.borderWidth = 1.0
        input.delegate = self
        view.addSubview(input)
        
        //        var inputBorder = UIView(frame: CGRectMake(20, screenHeight/2-74, screenWidth-40, 1))
        //        inputBorder.backgroundColor = UIColor.lightGrayColor()
        //        view.addSubview(inputBorder)
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = 100.0 //Location will only update if they move more than 100 metres
        locationManager.startUpdatingLocation()
        
        view.backgroundColor = UIColor.blackColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if activeQuestion == questions[0] { //If activeQuestion is Q1
            if input.text != "" { //If the user types something as their name
                name = input.text //Saves the name to var: name
                question2.title = "Hello, \(name). Gender scan failed, please manually input your gender." //Changes Q2.title to include var: name
                input.text = nil //Clears input.text, setting up for Q2
                activeQuestion = questions[1] //Moves the activeQuestion on to Q2
                output.text = activeQuestion.title //Changes output.text to display Q2.title
                //     output.sizeToFit()
            } else { //Else if the user types nothing
                let ac = UIAlertController(title: "System Error: 3230_ac334", message: "My scans detect no user input", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
                input.text = nil //Clears text field
            }
            return true
            
        } else if activeQuestion == questions[1] { //Or if activeQuestion is Q2
            if let index = question2.acceptedAnswers.indexOf(input.text!) { //Checks if input.text = any accepted answer of Q2
                gender = question2.acceptedAnswers[index] //Saves the selected gender to var: gender
                question3.title = "Gender: '\(gender)' saved. Is your current location your home?"
                input.text = nil
                activeQuestion = questions[2]
                output.text = activeQuestion.title
                
                print(name,", ", gender)
            } else { //If input.text doesn't = any accepted answer of Q2
                let ac = UIAlertController(title: "I'm sorry, I don't understand that.", message: "Accepted answers: Male, Female, Boy, Girl", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
                input.text = nil //Clears text field
            }
            return true
            
        } else if activeQuestion == questions[2] {
            if input.text == question3.acceptedAnswers[0] {
                if let location = locationManager.location { //This func and closure convertlocation from CLLocation to CLPlacemark, so it's readable
                    reverseGeocode(location, completion: { (returnedLocation:CLPlacemark) in
                        
                        self.homeLocation = returnedLocation
                        
                        print(returnedLocation)
                        print(returnedLocation.name)
                        print(returnedLocation.country)
                        
                        let ac = UIAlertController(title: "Home Location", message: "Home location set to \(returnedLocation.name!), \(returnedLocation.thoroughfare!), \(returnedLocation.postalCode!), \(returnedLocation.country!).", preferredStyle: .Alert)
                        ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                        self.presentViewController(ac, animated: true, completion: nil)
                        
                    })
                    
                    
                }
                
                input.text = nil
                output.text = "End of prototype"
                input.enabled = false
                //   input.removeFromSuperview() //
                input.attributedPlaceholder =  NSAttributedString(string: "System Disabled, Contact Admin ", attributes: [NSForegroundColorAttributeName:UIColor(red: 77/255, green: 192/255, blue: 86/255, alpha: 0.7)])
                
                
            } else if input.text == question3.acceptedAnswers[1] || input.text != question3.acceptedAnswers[0] || input.text != question3.acceptedAnswers[1] {
                let ac = UIAlertController(title: "Have you enabled Location Services?", message: "I won't tell the NSA where you are, I promise.", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
                input.text = nil //Clears text field
            }
            
            
        }
        return true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        
        //        if let newLocation = newLocation {
        //
        //        }
    }
    
    func reverseGeocode (location: CLLocation, completion:(returnedLocation:CLPlacemark)->Void) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) -> Void in
            if let placemark = placemark{
                
                completion(returnedLocation: placemark[0])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

