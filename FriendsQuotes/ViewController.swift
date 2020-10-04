//
//  ViewController.swift
//  FriendsQuotes
//
//  Created by preety on 27/9/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var peopleImage: UIImageView!
    
    
            // ----------- Launch Screen CODE Part ----------------
    let arImage = UIImageView(image: UIImage(named: "logo")!)
    let splashView = UIView()
    var networkData: NetworkData?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultLook()
        quoteLabel.flash(animation: .opacity, withDuration: 1, repeatCount: 2)
        peopleLabel.flash(animation: .opacity, withDuration: 1, repeatCount: 2)
        peopleImage.flash(animation: .opacity, withDuration: 1, repeatCount: 2)

    }
    
    
    func defaultLook(){ //after view gets loaded
        
         //----splashview design part
        splashView.backgroundColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 1.0) //red color appears
        view.addSubview(splashView)
        splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        arImage.contentMode = .scaleAspectFit
        splashView.addSubview(arImage)
        arImage.frame = CGRect(x: splashView.frame.midX - 100, y: splashView.frame.midY - 100, width: 200, height: 200)
        
        //----Button design Part---
        quoteButton.layer.cornerRadius = 8
        quoteButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        quoteButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        quoteButton.layer.shadowOpacity = 1.0
        quoteButton.layer.shadowRadius = 2.0
    }
    
     //logo shrinks
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.scaleDownAnimation()
        }
    }
    
    func scaleDownAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.arImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { ( success ) in
            self.scaleUpAnimation()
        }
    }
    
    //logo gets larger
    func scaleUpAnimation() {
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
            self.arImage.transform = CGAffineTransform(scaleX: 5, y: 5)
        }) { (success) in
            self.removeSplashScreen()
        }
    }
    
    func  removeSplashScreen() {
        splashView.removeFromSuperview()
    }

    
                    //------------ Network Part --------
    func newQuote() {
       guard let url = URL(string: "https://friends-quotes-api.herokuapp.com/quotes/random") else {return}
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
       
       URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data else { return }
            do {
                self.networkData = try JSONDecoder().decode(NetworkData.self, from: data)
                DispatchQueue.main.async {
                       if let totalData = self.networkData {
                           print(totalData.quote + " " + totalData.character)
                        
                       self.quoteLabel.text = totalData.quote
                       self.peopleLabel.text = totalData.character
                       
                        
                        if(totalData.character == "Ross"){
                            self.peopleImage.image = #imageLiteral(resourceName: "ross")
                        }
                        else if(totalData.character == "Monica"){
                            self.peopleImage.image = #imageLiteral(resourceName: "monica")
                        }
                        else if(totalData.character == "Rachel"){
                            self.peopleImage.image = #imageLiteral(resourceName: "rachel")
                        }
                        else if(totalData.character == "Chandler"){
                            self.peopleImage.image = #imageLiteral(resourceName: "chandler")
                        }
                        else if(totalData.character == "Phoebe"){
                            self.peopleImage.image = #imageLiteral(resourceName: "phoebe")
                        }
                        else if(totalData.character == "Joey"){
                            self.peopleImage.image = #imageLiteral(resourceName: "joey")
                        }
                    }
                }
            }
            catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        } .resume()
    }
    
    
    
    @IBAction func getMoreQuote(_ sender: Any) {
        
        MusicPlayer.shared.playSoundEffect(soundEffect: "B")
        quoteButton.startWiggling() //as startWiggling func is an extension
        self.view.backgroundColor = BackgroundColorPalette().randomColor()
        quoteLabel.flash(animation: .opacity, withDuration: 0.5, repeatCount: 1)
        newQuote()
        
    }
    
    
}

