//
//  AboutUsViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 07/06/22.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBOutlet weak var aboutUsTV: UITableView!
    
    let aboutUsTitle = ["Every time you attribute,",
                        "Flaticon License"]
    let aboutUSUrl = ["Select your favorite social network and share our icons with your contacts or friends, if you do not have these social networks copy the link and paste it in the one you use. For more information read the",
                      "Free for personal and commercial purpose with attribution"]

    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsTV.delegate = self
        aboutUsTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    

}

extension AboutUsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutUsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        cell.title.text = aboutUsTitle[indexPath.row]
        cell.disc.text = aboutUSUrl[indexPath.row]
        return cell
    }
    
    
}
