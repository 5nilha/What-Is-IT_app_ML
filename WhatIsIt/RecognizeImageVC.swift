//
//  RecognizeImageVC.swift
//  WhatIsIt
//
//  Created by Fabio Quintanilha on 12/2/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit
import CoreML
import Vision

class RecognizeImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    let imagePicker = UIImagePickerController() //Creates an imacgePicker comntroller object
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    
    
    //tells the delegate that the users has picked an image and wants to do something with it
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      
        //Info contains the image that the user picked
        // Access the image that the user has picked and assign to userPickedImage
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
             imageVIew.image = userPickedImage
            
            //converts UIImage to CIImage
            guard let coreImage = CIImage(image: userPickedImage)
            else {
               fatalError("Couldn't convert to CIImage")
            }
            
            detect(image: coreImage)
        }
        else {
            print("No image available")
        }
        
        imagePicker.dismiss(animated: true, completion: nil) 
    }
    
    
    
    func detect(image: CIImage) {
        
        //Creates a object model using the VNCoreMLModel container to create a new object of InceptionV3 and getting its model property
        //This model will be used to classify the image
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model)
            else {
                fatalError("Loading CoreML Model Failed")
            }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation]
                else {
                    fatalError("Model failed to process image")
                }

            if let firstResult = results.first {

                print("Developer: \(firstResult.identifier)")
                self.imageLabel.text = firstResult.identifier
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch{
            print(error)
        }
        
        
    }
    
    
    
    @IBAction func cameraBtnTapped(_ sender: UIBarButtonItem) {
        //presents the image picker
        present(imagePicker, animated: true, completion: nil)
        
    }

}
