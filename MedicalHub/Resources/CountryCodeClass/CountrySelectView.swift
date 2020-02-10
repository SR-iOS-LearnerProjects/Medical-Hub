//
//  CountrySelectView.swift
//  terncommerce
//
//  Created by 朱慧平 on 2018/1/30.
//  Copyright © 2018年 terncommerce. All rights reserved.
//

import UIKit
//import SwiftyJSON
public enum DisplayLanguageType{
    case chinese
    case english
    case spanish
    case arabic
}

public enum DisplayNationType{
    case arabic
    case english
}

public enum DisplayNationOrCountry{
    case countyName
    case NationName
}

open class CountrySelectView: UIView {
    public static let shared = CountrySelectView()
    public var selectedCountryCallBack : ((_ countryDic: [String:Any])->(Void))!
    fileprivate var countryTableView = UITableView()
    fileprivate var searchCountrys : [[String:Any]]!
    fileprivate var searchBarView = UISearchBar()
    fileprivate var regex = ""
    
    fileprivate var _searchBarPlaceholder: String = "search"
    public var searchBarPlaceholder: String{
        get{
            return _searchBarPlaceholder
        }
        set{
            _searchBarPlaceholder = newValue
            searchBarView.placeholder = _searchBarPlaceholder
        }
    }
    fileprivate var _countryNameFont: UIFont = UIFont.systemFont(ofSize: 16)
    public var countryNameFont:UIFont{
        get{
            return _countryNameFont
        }
        set{
            _countryNameFont = newValue
            countryTableView.reloadData()
        }
    }
    fileprivate var _countryPhoneCodeFont: UIFont = UIFont.systemFont(ofSize: 14)
    public var countryPhoneCodeFont:UIFont{
        get{
            return _countryPhoneCodeFont
        }
        set{
            _countryPhoneCodeFont = newValue
            countryTableView.reloadData()
        }
    }
    fileprivate var _countryNameColor: UIColor = .black
    public var countryNameColor:UIColor{
        get{
            return _countryNameColor
        }
        set{
            _countryNameColor = newValue
            countryTableView.reloadData()
        }
    }
    fileprivate var _countryPhoneCodeColor: UIColor = .gray
    public var countryPhoneCodeColor:UIColor{
        get{
            return _countryPhoneCodeColor
        }
        set{
            _countryPhoneCodeColor = newValue
            countryTableView.reloadData()
        }
    }
    fileprivate var _barTintColor:UIColor = .green
    public var barTintColor:UIColor{
        get{
            return _barTintColor
        }
        set{
            _barTintColor = newValue
            searchBarView.tintColor = _barTintColor
        }
    }
    fileprivate var _displayLanguage : DisplayLanguageType = .english
    public var displayLanguage:DisplayLanguageType{
        get{
            return _displayLanguage
        }
        set{
            _displayLanguage = newValue
            countryTableView.reloadData()
        }
    }
    
    fileprivate var _displayNation : DisplayNationType = .english
    public var displayNationLanguage: DisplayNationType {
        get{
            return _displayNation
        }
        set {
            _displayNation = newValue
            countryTableView.reloadData()
        }
    }
    
    fileprivate var _displayNationNameCountryName: DisplayNationOrCountry = .countyName
    public var displayNationNameCountryName: DisplayNationOrCountry {
        get {
            return _displayNationNameCountryName
        }
        set {
            _displayNationNameCountryName = newValue
            countryTableView.reloadData()
        }
    }
    
///
    func getUserDefaultsValue(for key: String) -> String
    {
        let value = UserDefaults.standard.string(forKey: key);
        if value == nil
        {
            return "";
        }
        return value!
    }
    
    let countryResponseKey                      = "countryResponse"
    
    //get json from string
    func getJSON(_ keyv :  String) -> JSON
    {
        var resultJSON = JSON()
        let jsonSTR =  UserDefaults.standard.string(forKey: keyv)
        if jsonSTR == nil
        {
            return resultJSON;
        }
        if let data = jsonSTR!.data(using: .utf8) {
            if let jsonObject = try? JSON(data: data) {
                resultJSON = jsonObject;
            }
        }
        return resultJSON
    }
    
    convenience init() {
        self.init(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height))
        let userDStr = getUserDefaultsValue(for: countryResponseKey)
        if userDStr == "" {
        }
        else {
            let countryDetails = getJSON(countryResponseKey)
            CountryCodeJsonSome = countryDetails["countries_nationalities"].arrayObject as! [[String : Any]]
            CountryCodeJsonSome = countryDetails["countries_nationalities"].arrayObject! as! [[String : Any]]
        }
        searchCountrys = CountryCodeJsonSome //CountryCodeJson
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(self.dismiss))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        self.addSubview(countryTableView)
        countryTableView.register(CountryTableViewCell.classForCoder(), forCellReuseIdentifier: "CountryTableViewCell")
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.separatorStyle = .none
        countryTableView.backgroundColor = .clear
        
        
        searchBarView.placeholder = "search"
        searchBarView.backgroundColor = .white
        searchBarView.backgroundImage = UIImage(named:"")
        searchBarView.barTintColor = .white
        searchBarView.tintColor = UIColor.green
        searchBarView.showsCancelButton = false
        searchBarView.delegate = self
        searchBarView.frame = CGRect(x:0,y:0,width:0.8*self.frame.size.width,height:44)
        countryTableView.tableHeaderView = searchBarView
        countryTableView.layer.masksToBounds = true
        countryTableView.layer.cornerRadius = 5.0
        
    }
    func setLayout() {
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy:.equal, toItem:self.superview!, attribute: .width, multiplier:1.0, constant:0.0))
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy:.equal, toItem:self.superview!, attribute: .height, multiplier:1.0, constant:0.0))
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy:.equal, toItem:self.superview!, attribute: .centerX, multiplier:1.0, constant:0))
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy:.equal, toItem:self.superview!, attribute: .centerY, multiplier:1.0, constant:0))
        
        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .width, relatedBy:.equal, toItem:self, attribute: .width, multiplier:0.8, constant:0))
        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .height, relatedBy:.equal, toItem:self, attribute: .height, multiplier:0.7, constant:0))
        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1.0, constant: 0))
        
        
    }
    public func show() {
        
        if let window = UIApplication.shared.delegate!.window! {
            window.addSubview(self)
        }
        searchBarView.text = ""
        searchCountrys = CountryCodeJsonSome
        self.countryTableView.reloadData()
        self.setLayout()
    }
    @objc public func dismiss() {
        self.removeFromSuperview()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private typealias searchBarDelegate = CountrySelectView
extension searchBarDelegate : UISearchBarDelegate{
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            searchCountrys = CountryCodeJsonSome //CountryCodeJson
            countryTableView.reloadData()
            return
        }
        
        self.getRegexString(searchString: searchText.lowercased())
        var results :[[String:Any]] = []
        for countryDic in CountryCodeJsonSome { //CountryCodeJson {
            let zh = countryDic["country_english"] as! String
            let en = countryDic["country_english"] as! String
            let es = countryDic["country_english"] as! String
            let ar = countryDic["country_arabic"] as! String
            let code = "\(countryDic["code"] as! String)"
            let locale = countryDic["locale"] as! String
            if self.checkSearchStringCharHas(compareString: zh.lowercased())||self.checkSearchStringCharHas(compareString: en.lowercased().replacingOccurrences(of: " ", with: ""))||self.checkSearchStringCharHas(compareString: es.lowercased().replacingOccurrences(of: " ", with: ""))||self.checkSearchStringCharHas(compareString:
                ar.lowercased().replacingOccurrences(of: " ", with: ""))||self.checkSearchStringCharHas(compareString: code)||self.checkSearchStringCharHas(compareString: locale.lowercased().replacingOccurrences(of: " ", with: "")){
                results.append(countryDic)
            }
        }
        searchCountrys = results
        countryTableView.reloadData()
    }
    func getRegexString(searchString: String){
        var str :String = ""
        let count = searchString.count
        for index in 0..<count {
            let i = searchString.index(searchString.startIndex, offsetBy: index, limitedBy: searchString.endIndex)
            if str.count == 0{
                str = "(^|[a-z0-9\\u4e00-\\u9fa5])+[\(searchString[i!])]"
            }else{
                str = "\(str)+[a-z0-9\\u4e00-\\u9fa5]*[\(searchString[i!])]"
            }
            print(searchString[i!])
        }
        regex = "\(str)+[a-z0-9\\u4e00-\\u9fa5]*$"
    }
    func checkSearchStringCharHas(compareString: String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: compareString)
        return isValid
    }
    
}
private typealias tapGestureDelegate = CountrySelectView
extension tapGestureDelegate : UIGestureRecognizerDelegate{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if NSStringFromClass((touch.view?.classForCoder)!).components(separatedBy: ".").last! == "UITableViewCellContentView"{
            return false
        }
        return true
    }
}
private typealias tableViewDelegate = CountrySelectView
extension tableViewDelegate : UITableViewDelegate{
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dic = searchCountrys[indexPath.row]
        dic["countryImage"] = UIImage(named:"CountryPicker.bundle/\(searchCountrys[indexPath.row]["locale"] as! String)")
        self.selectedCountryCallBack(dic)
        self.dismiss()
    }
}
private typealias tableViewDataSource = CountrySelectView
extension tableViewDataSource : UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCountrys.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "CountryTableViewCell"
        
        var countryCell:CountryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? CountryTableViewCell
        
        if countryCell == nil {
            
            countryCell=CountryTableViewCell(style: .default, reuseIdentifier: indentifier)
        }
        
        //for selecting country or nation name
        if _displayNationNameCountryName == .countyName {
            countryCell.phoneCodeLabel.alpha = 1.0
            // for country name
            if _displayLanguage == .english {
                countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["country_english"] as! String)
            }
            if _displayLanguage == .chinese {
                countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["country_english"] as! String)
            }
            if _displayLanguage == .spanish {
                countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["country_english"] as! String)
            }
            if _displayLanguage == .arabic {
                countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["country_arabic"] as! String)
            }
        }
        
        if _displayNationNameCountryName == .NationName {
            countryCell.phoneCodeLabel.alpha = 0.0
            //for nation name
            if _displayNation == .english {
               countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["nationality_english"] as! String)
            }
            if _displayNation == .arabic {
               countryCell.countryNameLabel.text = (searchCountrys[indexPath.row]["nationality_arabic"] as! String)
            }
        }
        
        
        countryCell.countryNameLabel.font = _countryNameFont
        countryCell.countryNameLabel.textColor = _countryNameColor
        let path = Bundle(for: CountrySelectView.self).resourcePath! + "/CountryPicker.bundle"
        let CABundle = Bundle(path: path)!
        countryCell.countryImageView.image = UIImage(named: "\(searchCountrys[indexPath.row]["locale"] as! String)", in:  CABundle, compatibleWith: nil)
        
        countryCell.phoneCodeLabel.text = "+\(searchCountrys[indexPath.row]["code"] as! String)"
        countryCell.phoneCodeLabel.font = _countryPhoneCodeFont
        countryCell.phoneCodeLabel.textColor = _countryPhoneCodeColor
        return countryCell
    }
}

