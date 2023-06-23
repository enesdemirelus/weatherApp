

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    var locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        longitude = locations[0].coordinate.longitude
        latitude = locations[0].coordinate.latitude
        print(longitude)
        
    }
    
    
    @IBAction func findButton(_ sender: Any) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=11d31183bf024265f33a30612c4f1060&units=imperial%22.addingPercentEncoding(withAllowedCharacters")
        
        

        
    
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error")
            } else {
            if data != nil {
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
            DispatchQueue.main.async {
            
                
                   if let weather = jsonResponse["main"] as? [String: Any] {
                    let havadurumu = weather["temp"] as? Double
                       let fahrenait = (1.8) * (havadurumu! - 273) + 32
                       let roundedNumber = Int(floor(fahrenait))
                       self.weatherLabel.text = "Weather: \(roundedNumber) F"
                       
                       if roundedNumber < 50 {
                           self.imageView.image = UIImage(named: "snow")
                       } else if roundedNumber > 50 && roundedNumber < 65 {
                           self.imageView.image = UIImage(named: "suncloud")
                       } else if roundedNumber > 65 {
                           self.imageView.image = UIImage(named: "sunny")
                       }
                       
                       
                       
                 }
                  
                    
                
           
        }
        } catch {
            print("error")
        }
        }
        }
        }
        task.resume()
        
        
        
        
    }
    
    
    
}
    

