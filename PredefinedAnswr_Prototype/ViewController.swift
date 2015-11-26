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
    var activeQuestion: Question {return questions[questionIndex]} //Setting activeQuestion to be the questionIndex position in the array, so that starts as array index 0, so the first question is the default activeQuestion
    var questionIndex = 0
    
    var question1:Question!; var question2:Question!; var question3:Question!; var question4:Question!; var question5:Question!
    
    var name:String!
    var gender:String!
    var homeLocation:CLPlacemark?
    
    var input:UITextField!
    var nameSubmit:Bool = false
    var keyboardSubmit:Bool = false
    var output:UILabel!
    var inputBorder:UIView!
    var lButton:UIButton!; var rButton:UIButton!
    
    var colourButton1:UIButton!; var colourButton2:UIButton!; var colourButton3:UIButton!; var colour:UIColor!
    
    var buttonArray = [UIButton!]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colour = UIColor.greenColor()
        
        //Creates questions
        question1 = Question(title: "What's your name?", acceptedAnswers:nil, correctResponce: "Name has been saved", needsKeyboard: true, willBeSaved: true)
        question2 = Question(title: "Hello, \(name), what's your gender?", acceptedAnswers: ["Male","Female"], correctResponce: "Gender saved as \(gender)", needsKeyboard: false, willBeSaved: true)
//        question3 = Question(title: "Is your current location your home?", acceptedAnswers: ["Yes","No"], correctResponce: "Home location saved as \(homeLocation)", needsKeyboard: false, willBeSaved: true)
        question3 = Question(title: "Left or right?", acceptedAnswers: ["Left","Right"], correctResponce: "As I thought, good choice.", needsKeyboard: false, willBeSaved: false)
        question4 = Question(title: "Red, Green or Blue?", acceptedAnswers: ["Red", "Green", "Blue"], correctResponce: "If you're reading this, prototype has worked!", needsKeyboard: true, willBeSaved: false)
        
        //Adds questions to questions array
        questions += [question1,question2,question3,question4/*question5*/]
        
        
        
        //Sets default active question to Q1
        //activeQuestion = questions[0]
        
        
        //Draw content+layout
        output = PaddedLabel(frame:CGRect(x: 10, y: 270, width: screenWidth-20, height: 100))
        output.text = activeQuestion.title
        output.font = UIFont(name: "Menlo-Regular", size: 16)
        output.textColor = colour
        output.textAlignment = NSTextAlignment.Left
        output.numberOfLines = 0
        output.layer.borderColor = colour.CGColor
        output.layer.borderWidth = 1.0
        view.addSubview(output)
        
        input = UITextField(frame: CGRect(x: 10, y: 400, width: screenWidth-20, height: 40))
        input.attributedPlaceholder =  NSAttributedString(string: "Type shit here", attributes: [NSForegroundColorAttributeName:colour])
        input.font = UIFont(name: "Menlo-Regular", size: 16)
        input.textColor = colour
        input.textAlignment = NSTextAlignment.Left
        input.leftView = UIView(frame: CGRectMake(0, 0, 10, 40))
        input.leftViewMode = UITextFieldViewMode.Always
        input.autocapitalizationType = UITextAutocapitalizationType.Sentences
        input.keyboardAppearance = UIKeyboardAppearance.Dark
        input.layer.borderColor = colour.CGColor
        input.layer.borderWidth = 1.0
        input.delegate = self
        view.addSubview(input)
        input.hidden = true
        
        
        lButton = UIButton(frame: CGRect(x: 10, y: 400, width: screenWidth/2-15, height: 50))
        lButton.backgroundColor = UIColor.blackColor()
       // lButton.setTitle(question2.acceptedAnswers[0], forState: UIControlState.Normal)
        lButton.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
        lButton.setTitleColor(colour, forState: UIControlState.Normal)
        lButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        lButton.layer.borderWidth = 1.0
        lButton.layer.borderColor = colour.CGColor
        view.addSubview(lButton)
        lButton.hidden = true
        
        
        rButton = UIButton(frame: CGRect(x: screenWidth/2+5, y: 400, width: screenWidth/2-15, height: 50))
        rButton.backgroundColor = UIColor.blackColor()
        //rButton.setTitle(question2.acceptedAnswers[1], forState: UIControlState.Normal)
        rButton.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
        rButton.setTitleColor(colour, forState: UIControlState.Normal)
        rButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        rButton.layer.borderWidth = 1.0
        rButton.layer.borderColor = colour.CGColor
        view.addSubview(rButton)
        rButton.hidden = true
        
        buttonArray += [lButton,rButton]
        
        colourButton1 = UIButton(frame: CGRect(x: screenWidth-120, y: 15, width: 20, height: 20))
        colourButton1.backgroundColor = UIColor.redColor()
        colourButton1.setTitle("R", forState: UIControlState.Normal)
        colourButton1.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
        colourButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        colourButton1.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(colourButton1)
        colourButton2 = UIButton(frame: CGRect(x: screenWidth-80, y: 15, width: 20, height: 20))
        colourButton2.backgroundColor = UIColor.greenColor()
        colourButton2.setTitle("G", forState: UIControlState.Normal)
        colourButton2.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
        colourButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        colourButton2.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(colourButton2)
        colourButton3 = UIButton(frame: CGRect(x: screenWidth-40, y: 15, width: 20, height: 20))
        colourButton3.backgroundColor = UIColor.blueColor()
        colourButton3.setTitle("B", forState: UIControlState.Normal)
        colourButton3.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
        colourButton3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        colourButton3.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(colourButton3)

        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = 100.0 //Location will only update if they move more than 100 metres
        locationManager.startUpdatingLocation()
        
        view.backgroundColor = UIColor.blackColor()
        
        questionHandler(activeQuestion)
    }
    
func questionHandler(question: Question) {
    
    input.hidden = true; lButton.hidden = true; rButton.hidden = true
    
    if questionIndex == questions.count { //If the current question index is equal to the length of questions array, i.e the final question, return from function
        return
    }
    
    if activeQuestion.needsKeyboard { // If the question's needsKeyboard property is true, unhide the keyboard
        input.hidden = false
        
        print("Keyboard is needed!")
        


    } else { // If the question's needsKeyboard property is false, unhide the buttons
        print("Buttons are needed!")
        lButton.hidden = false
        rButton.hidden = false
    }
    answersHandler()
}
 
func answersHandler(){
    if activeQuestion.needsKeyboard {
            if  activeQuestion.acceptedAnswers == nil {
                nameSubmit = true
                print("We're on Question 1")
            } else {
                keyboardSubmit = true
                print("Keyboard question but not Question 1")
            }
    } else if activeQuestion.needsKeyboard == false {
        output.text = activeQuestion.title
        lButton.setTitle(activeQuestion.acceptedAnswers![0], forState: UIControlState.Normal)
        rButton.setTitle(activeQuestion.acceptedAnswers![1], forState: UIControlState.Normal)
    }
}
    
func textFieldShouldReturn(textField: UITextField) -> Bool { // Handles the user's answer to Question 0
    if nameSubmit == true {
        if input.text == "" || input.text!.containsString(" ") {
            let ac = UIAlertController(title: "System Error: 3230_ac334", message: "My scans detect no user input", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            input.text = nil //Clears text field
        } else if input.text != "" {
            name = input.text //Saves the name to var: name
            question2.title = "Hello, \(name), what's your gender?"
            print("Name is set to '\(name)'")
            ++questionIndex
            print("Advancing to question \(questionIndex+1)")
            input.text = nil //Clears text field
            output.text = nil
            view.endEditing(true)
            questionHandler(activeQuestion)
        }
    }
    
    if keyboardSubmit == true {
        if let _ = activeQuestion.acceptedAnswers!.indexOf(input.text!) {
            input.text = ""
            output.text = activeQuestion.correctResponce
        }
    }
    return true
}

func buttonHandler(sender:UIButton){
    if sender == lButton {
        
    } else if sender == rButton {
        
    }
}


func changeColour(sender:UIButton){
    switch sender {
        case colourButton1:
            colour = UIColor.redColor()
    
        case colourButton2:
            colour = UIColor.greenColor()
        
        case colourButton3:
            colour = UIColor.blueColor()
        
        default:
            colour = UIColor.greenColor()
    }
    output.textColor = colour
    output.layer.borderColor = colour.CGColor
    input.attributedPlaceholder = NSAttributedString(string: "Type shit here", attributes: [NSForegroundColorAttributeName:colour])
    input.textColor = colour
    input.layer.borderColor = colour.CGColor
    lButton.layer.borderColor = colour.CGColor
    rButton.layer.borderColor = colour.CGColor
    lButton.setTitleColor(colour, forState: UIControlState.Normal)
    rButton.setTitleColor(colour, forState: UIControlState.Normal)
}
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        if activeQuestion == questions[0] { //If activeQuestion is Q1
//            if input.text != "" { //If the user types something as their name
//                name = input.text //Saves the name to var: name
//                question2.title = "Hello, \(name). Gender scan failed, please manually input your gender." //Changes Q2.title to include var: name
//                input.text = nil //Clears input.text, setting up for Q2
//                input.removeFromSuperview()
//                view.addSubview(lButton)
//                view.addSubview(rButton)
//                activeQuestion = questions[1] //Moves the activeQuestion on to Q2
//                output.text = activeQuestion.title //Changes output.text to display Q2.title
//                //     output.sizeToFit()
//            } else { //Else if the user types nothing
//                let ac = UIAlertController(title: "System Error: 3230_ac334", message: "My scans detect no user input", preferredStyle: .Alert)
//                ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
//                presentViewController(ac, animated: true, completion: nil)
//                input.text = nil //Clears text field
//            }
//            return true
//        }
//        return true
//    }
    
    
            
//   if activeQuestion == questions[2] {
//        if input.text == question3.acceptedAnswers[0] {
//            if let location = locationManager.location { //This func and closure convertlocation from CLLocation to CLPlacemark, so it's readable
//                reverseGeocode(location, completion: { (returnedLocation:CLPlacemark) in
//                    
//                    self.homeLocation = returnedLocation
//                    
//                    print(returnedLocation)
//                    print(returnedLocation.name)
//                    print(returnedLocation.country)
//                    
//                    let ac = UIAlertController(title: "Home Location", message: "Home location set to \(returnedLocation.name!), \(returnedLocation.thoroughfare!), \(returnedLocation.postalCode!), \(returnedLocation.country!).", preferredStyle: .Alert)
//                    ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
//                    self.presentViewController(ac, animated: true, completion: nil)
//                    
//                })
//                
//                
//            }
//            
//            input.text = nil
//            output.text = "End of prototype"
//            input.enabled = false
//            //   input.removeFromSuperview() //
//            input.attributedPlaceholder =  NSAttributedString(string: "System Disabled, Contact Admin ", attributes: [NSForegroundColorAttributeName:UIColor(red: 77/255, green: 192/255, blue: 86/255, alpha: 0.7)])
//            
//            
//        } else if input.text == question3.acceptedAnswers[1] || input.text != question3.acceptedAnswers[0] || input.text != question3.acceptedAnswers[1] {
//            let ac = UIAlertController(title: "Have you enabled Location Services?", message: "I won't tell the NSA where you are, I promise.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
//            presentViewController(ac, animated: true, completion: nil)
//            input.text = nil //Clears text field
//        }
//        
//        
//    }
//    return true
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let newLocation = locations.last
//        
//        //        if let newLocation = newLocation {
//        //
//        //        }
//    }
//    
//    func reverseGeocode (location: CLLocation, completion:(returnedLocation:CLPlacemark)->Void) {
//        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) -> Void in
//            if let placemark = placemark{
//                
//                completion(returnedLocation: placemark[0])
//            }
//        }
//    }
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


