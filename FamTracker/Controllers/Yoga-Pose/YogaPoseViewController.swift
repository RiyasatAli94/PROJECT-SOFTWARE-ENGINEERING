//
//  YogaPoseViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 02/06/22.
//

import UIKit
import SDWebImage


class YogaPoseViewController: UIViewController {
    @IBOutlet weak var YogaTV: UITableView!
    var yogaArray : Yoga!
    override func viewDidLoad() {
        super.viewDidLoad()
        YogaTV.delegate = self
        YogaTV.dataSource = self
        getData()
    }
    
    @IBAction func dimiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension YogaPoseViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if yogaArray == nil{
            return 0
        }
        return yogaArray.items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaPoseTableViewCell", for: indexPath) as! YogaPoseTableViewCell
        cell.yogaEngName.text = Utils.unwarpString(string: yogaArray.items![indexPath.row].english_name)
        cell.yogaSunName.text = Utils.unwarpString(string: yogaArray.items![indexPath.row].sanskrit_name)
        let url = URL(string: Utils.unwarpString(string: yogaArray.items![indexPath.row].img_url))!

        cell.yogaImg.sd_setImage(with: url, placeholderImage: UIImage(named: "yoga-pose"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = Utils.unwarpString(string: yogaArray.items![indexPath.row].english_name)
        ScreensManager.shared.createYourOwnShow(img: UIImage(named: "yoga-pose")!, title: title, on: self, modal: true, animated: false)
    }
    
    
}

extension YogaPoseViewController{
    func getData() {
        Api.getAPIData(){ (status: Int, success: Bool, jsonData: Data?) -> Bool in
                if status >= 200 && status < 300 {
                    if let jsonData = jsonData {
                        if let test = try? JSONDecoder().decode(Yoga.self, from: jsonData) {
                            DispatchQueue.main.async {
                                self.yogaArray = test
                                self.YogaTV.reloadData()
                            }
                        }
                    }
                }
            return true
        }
    }
}

