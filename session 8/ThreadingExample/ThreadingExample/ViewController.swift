//
//  ViewController.swift
//  ThreadingExample
//
//  Created by Rasko Gojkovic on 2/28/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image_0: UIImageView!
    @IBOutlet weak var image_1: UIImageView!
    @IBOutlet weak var image_2: UIImageView!
    
    let img0 = UIImage(named: "Nature_0")
    let img1 = UIImage(named: "Nature_1")
    let img2 = UIImage(named: "Nature_2")
    
    let dispQueue0 = DispatchQueue(label: "myDispQueue0", qos: .userInitiated)
    let dispQueue1 = DispatchQueue(label: "myDispQueue1", qos: .utility)
    let dispQueue2 = DispatchQueue(label: "myDispQueue2", qos: .background)

    var imgProcessor0 : ImageProcessor!
    var imgProcessor1 : ImageProcessor!
    var imgProcessor2 : ImageProcessor!
    
    let myDispatchGr = DispatchGroup()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProcessor0 = ImageProcessor(image: img0, imageView: self.image_0)
        imgProcessor1 = ImageProcessor(image: img1, imageView: self.image_1)
        imgProcessor2 = ImageProcessor(image: img2, imageView: self.image_2)
        // Do any additional setup after loading the view, typically from a nib.
        image_0.image = img0
        image_1.image = img1
        image_2.image = img2
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReset(_ sender: Any) {
        image_0.image = img0
        image_1.image = img1
        image_2.image = img2
    }

    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func onProcess(_ sender: Any) {
        
        
        dispQueue0.async {
            self.imgProcessor0.processImage(pixelTransform: ImageProcessor.gray)
        }
        
        dispQueue0.async(group: myDispatchGr) {
            self.imgProcessor1.processImage(pixelTransform: ImageProcessor.gray)
        }
        
        dispQueue1.async(group: myDispatchGr) {
            self.imgProcessor2.processImage(pixelTransform: ImageProcessor.accentRed)
        }
        
        myDispatchGr.notify(queue: dispQueue2){
            self.dispQueue0.async {
                self.imgProcessor0.processImage(pixelTransform: ImageProcessor.redChannel)
            }
            self.dispQueue0.async {
                self.imgProcessor1.processImage(pixelTransform: ImageProcessor.accentGreen)
            }
            
        }
    }
    
    
    
}


