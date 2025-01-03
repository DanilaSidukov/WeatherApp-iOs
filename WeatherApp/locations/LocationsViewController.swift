//
//  ViewController.swift
//  WeatherApp
//
//  Created by Danila Sidukov on 03.02.2024.
//

import UIKit

class LocationsViewController: UIViewController {
    @IBOutlet var onLabelClicked: UILabel!

    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        onLabelClicked.text = "Still some test"
        onLabelClicked.textColor = .red
    }

    @IBAction func onButtonClicked(){
        count+=1
        onLabelClicked.text = "text changed to: \(count)"
    }

}
