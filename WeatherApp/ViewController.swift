//
//  ViewController.swift
//  WeatherApp
//
//  Created by Janardhan on 23/02/18.
//  Copyright © 2018 RanganathPavan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var placeTxtFld:UITextField!
    @IBOutlet weak var climateTable:UITableView!
    
    public var url:URL?
    var temp:String!
    var weather:String!
    var location:String!
    
    typealias JSONStandard = Dictionary<String, AnyObject>


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        

    }
    
    @IBAction func getData(_ sender: Any) {
        let title = placeTxtFld.text!
        
        if title.isEmpty == true {
            print("Textfield Empty")
        }else{
            print("Textfield Not Empty")
            url = URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=534426267d3ae8ba9be00ba92eb2684a&q=\(title)")!
            downloadData()
        }
    }
    
    
    
    func downloadData() {
        
        Alamofire.request(url!).responseJSON(completionHandler: {
            response in
            let result = response.result
            print(result)
            if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                
                self.temp = String(format: "%.0f °C", temp - 273.15)
                self.weather = weather
                self.location = "\(name), \(country)"
//                self.date = dt
               // print(dict)
                
                self.climateTable.reloadData()
                
            }
        })
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomeCellDesign",
            for: indexPath) as! CustomCell
        
        
        cell.temperature.text = temp
        cell.weather.text = weather
        cell.location.text = location
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder()
        
        return true;
    }
}

