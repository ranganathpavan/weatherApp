//
//  ViewController.swift
//  WeatherApp
//
//  Created by Janardhan on 23/02/18.
//  Copyright © 2018 RanganathPavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let weather = WeatherGetter()
        weather.getWeather("Chirala")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

