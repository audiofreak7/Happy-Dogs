//
//  ViewController.swift
//  Happy Dogs
//
//  Created by John Pospisil on 2/3/18.
//  Copyright © 2018 John Pospisil. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var dogPic: UIImageView!
    @IBOutlet weak var nextDogButton: UIButton!
    
    let dogDataURL = "https://dog.ceo/api/breeds/image/random"
    let randomDogURL = "https://dog.ceo/api/breeds/list"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nextDogButton.layer.cornerRadius = 10
        // nextDogButton.layer.borderWidth = 5
        // nextDogButton.layer.borderColor =  UIColor.gray.cgColor
        
        dogPic.layer.cornerRadius = 10
        
        getNextDogPic(url: dogDataURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    //MARK: - Networking
    //    /***************************************************************/
    func getNextDogPic(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the dog pic data")
                    let valueJSON : JSON = JSON(response.result.value!)
                    
                    self.updateDogPic(json: valueJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    //self.questionLabel.text = "Connection Issues"
                }
        }
        
        
        
    }
    
    //    //MARK: - JSON Parsing
    //    /***************************************************************/
    
    func updateDogPic(json : JSON) {
        
        // Retrieve the dog pic url, if it exists.
        if let dogURL = json["message"].string {
            

            
            // Get the image data from the net and download it to the device.
            Alamofire.request(dogURL).responseImage { response in
                if let dogPicture = response.result.value {
   
                    self.dogPic.image = dogPicture
                }
            }
            
        } else {
            print("Dog Unavailable")
        }
    }
    
    //    //MARK: - Network to get Dog Breed List
    //    /***************************************************************/
    func getBreedList(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Got breed list!")
                    let valueJSON : JSON = JSON(response.result.value!)
                    
                    self.printBreedList(json: valueJSON)
                    
                } else {
                    print("Error")
                }
        }
        
        
        
    }
    
    //    //MARK: - Parse Dog Breed List
    //    /***************************************************************/
    
    func printBreedList(json : JSON) {
        
        // Retrieve the dog pic url, if it exists.
        if let dogBreedList = json["message"].array {
            
            
            
            print(dogBreedList)
            
        } else {
            print("Dog Unavailable")
        }
    }
    
    
    
    

    @IBAction func nextDogButton(_ sender: UIButton) {
        getNextDogPic(url: dogDataURL)
        getBreedList(url: randomDogURL)
    }
    
}

