//
//  CodesPopOverViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 10/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

struct jsonCountryData {
    var name: String = ""
    var callingCodes: String = ""
    var flag: String = ""
    var borders: String = ""
    
    init() {}
    
    init(json:JSON){
        name = json["name"].stringValue
        callingCodes = json["callingCodes"][0].stringValue
        flag = json["flag"].stringValue
        borders = json["borders"][0].stringValue
    }
}

class CodesPopOverViewController: UIViewController {
    
    var countryArr = [jsonCountryData]()
    
    @IBOutlet var viewHolder: UIView!
    @IBOutlet var tableView: UITableView!

    var codesArr = ["+44","+92","+101","+414","+921","+111","+144","+192","+01","+441","+265","+365","+48","+22","+11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.cornerRadius = 8
        viewHolder.layer.cornerRadius = 8
        
        getJsonData()
        
    }
    
    func getJsonData() {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                for arr in json.arrayValue {
                    print(arr["callingcode"])
                    self.countryArr.append(jsonCountryData(json: arr))
                }
                
                print(self.countryArr)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    

    @IBAction func dismissBtnClick(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "EditProfile") as! EditProfileViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//        vc.phnNoBtnTitle
        dismiss(animated: true, completion: nil)
    }

}

extension CodesPopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CodesTableViewCell
        cell.codeLbl.text = "+" + countryArr[indexPath.row].callingCodes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile") as! EditProfileViewController
        
        vc.phnNoBtnTitle = "+" + countryArr[indexPath.row].callingCodes
            
//        vc.phnNoBtn.setTitle("\(codesArr[indexPath.row])", for: .normal)
//        dismiss(animated: true, completion: nil)
        dismiss(animated: true) {
             self.navigationController?.pushViewController(vc, animated: true)
        }
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
