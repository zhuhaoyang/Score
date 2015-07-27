//
//  ViewController.swift
//  棋牌计分
//
//  Created by Myth on 15/6/19.
//  Copyright (c) 2015年 Myth. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController {

    @IBOutlet weak var m_tableView: UITableView!
    @IBOutlet weak var nameA: UITextField!
    @IBOutlet weak var nameB: UITextField!
    @IBOutlet weak var nameC: UITextField!
    @IBOutlet weak var nameD: UITextField!
    @IBOutlet weak var nameE: UITextField!

    @IBOutlet weak var scoreA: UITextField!
    @IBOutlet weak var scoreB: UITextField!
    @IBOutlet weak var scoreC: UITextField!
    @IBOutlet weak var scoreD: UITextField!
    @IBOutlet weak var scoreE: UITextField!

    @IBOutlet weak var sumScore: UILabel!
    
    @IBOutlet weak var titleA: UILabel!
    @IBOutlet weak var titleB: UILabel!
    @IBOutlet weak var titleC: UILabel!
    @IBOutlet weak var titleD: UILabel!
    @IBOutlet weak var titleE: UILabel!

    @IBOutlet weak var btEdit: UIButton!
    @IBOutlet weak var btRecord: UIButton!
    @IBOutlet weak var btClear: UIButton!
    @IBOutlet weak var btBackGround: UIButton!
    @IBOutlet weak var btSymbol: UIButton!

//    @IBOutlet weak var nav: UINavigationBar!
    
    var isScore:Bool!
    
    var arrScore:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 0)
//        self.navigationController?.navigationBar.alpha = 1
//        self.navigationController?.navigationBar.translucent = false
//        self.navigationController?.navigationBar.hidden = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let notificationCentre = NSNotificationCenter.defaultCenter()
        notificationCentre.addObserver(self, selector: "textFieldTextDidChangeNotification", name:
            UITextFieldTextDidChangeNotification, object: nil)
//        notificationCentre.addObserver(self, selector: "handleKeyboardWillShow:", name:
//            UIKeyboardWillShowNotification, object: nil)
//        notificationCentre.addObserver(self, selector: "handleKeyboardWillHide:", name:
//            UIKeyboardWillHideNotification, object: nil)
        let def = NSUserDefaults.standardUserDefaults()
        if let arrData: [NSArray] = def.arrayForKey("arrData") as? [NSArray] {
            arrScore.addObjectsFromArray(arrData)
        }
        
//        let def = NSUserDefaults.standardUserDefaults()
//        if let arrData = def.arrayForKey("arrData") as? NSMutableArray {
//            arrScore.addObjectsFromArray(arrData as [AnyObject])
//        }
        
        
//        arrScore = NSUserDefaults.standardUserDefaults().arrayForKey("arrData")
        
        if let arrName: AnyObject = def.arrayForKey("arrName") as? AnyObject{
            nameA.text = arrName.objectAtIndex(0) as! String
            nameB.text = arrName.objectAtIndex(1) as! String
            nameC.text = arrName.objectAtIndex(2) as! String
            nameD.text = arrName.objectAtIndex(3) as! String
            nameE.text = arrName.objectAtIndex(4) as! String
        }
        
        updateTitle()
        
        isScore = true
        
        sumScore.text  = getSumScore() as String
        

//        if m_tableView.respondsToSelector("setSeparatorInset:") {
//            m_tableView.separatorInset = UIEdgeInsetsZero
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTitle(){
        var tempA = 0
        var tempB = 0
        var tempC = 0
        var tempD = 0
        var tempE = 0

        for obj in arrScore{
            var a = obj.objectAtIndex(0) as! String
            tempA += a.toInt()!
            var b = obj.objectAtIndex(1) as! String
            tempB += b.toInt()!
            var c = obj.objectAtIndex(2) as! String
            tempC += c.toInt()!
            var d = obj.objectAtIndex(3) as! String
            tempD += d.toInt()!
            var e = obj.objectAtIndex(4) as! String
            tempE += e.toInt()!
        }
        titleA.text = "\(nameA.text)\n\(tempA)"
        titleB.text = "\(nameB.text)\n\(tempB)"
        titleC.text = "\(nameC.text)\n\(tempC)"
        titleD.text = "\(nameD.text)\n\(tempD)"
        titleE.text = "\(nameE.text)\n\(tempE)"

    }
    
    func getSumScore() ->NSString{
        
        return String(format:"%d",
            scoreA.text.toInt()! +
                scoreB.text.toInt()! +
                scoreC.text.toInt()! +
                scoreD.text.toInt()! +
                scoreE.text.toInt()!)
    }
    
    @IBAction func edit(sender: UIButton) {
        if(btEdit.tag == 100){
            nameA.enabled = true
            nameB.enabled = true
            nameC.enabled = true
            nameD.enabled = true
            nameE.enabled = true
            btEdit.setTitle("编辑完成", forState:.Normal)
            isScore = false
            nameA.becomeFirstResponder()
            btEdit.tag = 101
        }else if(btEdit.tag == 101){
            nameA.enabled = false
            nameB.enabled = false
            nameC.enabled = false
            nameD.enabled = false
            nameE.enabled = false
            btEdit.setTitle("编辑名称", forState:.Normal)
            isScore = true
            self.hideKB(sender)
            updateTitle()

            let arr = [nameA.text, nameB.text, nameC.text, nameD.text, nameE.text];
            let def = NSUserDefaults.standardUserDefaults()
            def.setObject(arr, forKey: "arrName")
            def.synchronize()
            btEdit.tag = 100
        }
        
    }
    
    @IBAction func record(sender: UIButton) {
        var arr = [scoreA.text,scoreB.text,scoreC.text,scoreD.text,scoreE.text]
        arrScore.insertObject(arr, atIndex: 0)
        m_tableView.reloadData()
        var def = NSUserDefaults.standardUserDefaults()
        def.setObject(arrScore, forKey: "arrData")
        def.synchronize()
        
        updateTitle()
        scoreA.text = "0"
        scoreB.text = "0"
        scoreC.text = "0"
        scoreD.text = "0"
        scoreE.text = "0"
        sumScore.text = getSumScore() as String

    }
    
    @IBAction func clear(sender: UIButton) {
        
        var alert = UIAlertController(title: "注意!", message: "是否要清空数据?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "是", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.titleA.text = "\(self.nameA.text)\n0"
                self.titleB.text = "\(self.nameB.text)\n0"
                self.titleC.text = "\(self.nameC.text)\n0"
                self.titleD.text = "\(self.nameD.text)\n0"
                self.titleE.text = "\(self.nameE.text)\n0"
                self.scoreA.text = "0"
                self.scoreB.text = "0"
                self.scoreC.text = "0"
                self.scoreD.text = "0"
                self.scoreE.text = "0"
                self.sumScore.text = self.getSumScore() as String
                
                self.arrScore.removeAllObjects()
                self.m_tableView.reloadData()
                
                
                var def = NSUserDefaults.standardUserDefaults()
                def.setObject(self.arrScore, forKey: "arrData")
                def.synchronize()

            case .Cancel:
                println("Cancel")

            case .Destructive:
                println("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "否", style: .Cancel, handler:nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func hideKB(sender: UIButton) {
        nameA.resignFirstResponder()
        nameB.resignFirstResponder()
        nameC.resignFirstResponder()
        nameD.resignFirstResponder()
        nameE.resignFirstResponder()
        scoreA.resignFirstResponder()
        scoreB.resignFirstResponder()
        scoreC.resignFirstResponder()
        scoreD.resignFirstResponder()
        scoreE.resignFirstResponder()
        
    }
    
    func textFieldTextDidChangeNotification(){
        
        scoreA.text = "\((scoreA.text as NSString).integerValue)"
        scoreB.text = "\((scoreB.text as NSString).integerValue)"
        scoreC.text = "\((scoreC.text as NSString).integerValue)"
        scoreD.text = "\((scoreD.text as NSString).integerValue)"
        scoreE.text = "\((scoreE.text as NSString).integerValue)"
        
        sumScore.text = getSumScore() as String
        
    }
    
//    func textFieldDidBeginEditing(textField: UITextField!){
//        if(textField.keyboardType != UIKeyboardType.NumberPad){
//            isScore = false
//            if(btSymbol != nil && btSymbol.superview != nil){
//                btSymbol.removeFromSuperview()
//                btSymbol = nil
//            }
//            
//        }else{
//            isScore = true
//        }
//
//    }
    
//    func handleKeyboardWillShow(notification:NSNotification){
//
//        if(btSymbol == nil){
//            btSymbol = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//
//            btSymbol.setTitle("-/+", forState:.Normal)
//            btSymbol.setTitleColor(UIColor.blackColor(), forState: .Normal)
//            btSymbol.backgroundColor = UIColor.lightGrayColor()
//            btSymbol.frame = CGRectMake(184, 172, 77, 40);
//            btSymbol.addTarget(self, action: "changeSymbol:", forControlEvents: .TouchUpInside)
//        }
//        
////        if(scoreA.isFirstResponder() ||
////            scoreB.isFirstResponder() ||
////            scoreC.isFirstResponder() ||
////            scoreD.isFirstResponder()){
//        if(isScore == true){
//            var topWindow:UIWindow = UIApplication.sharedApplication().windows[1] as! UIWindow
//            topWindow.addSubview(btSymbol)
//        }
//
//        
//    }
//    
//    func handleKeyboardWillHide(notification:NSNotification){
//        if(btSymbol.superview != nil){
//            btSymbol.removeFromSuperview()
//        }
//        
//    }
    

    @IBAction func changeSymbol(sender: UIButton) {
        if(scoreA.isFirstResponder()){
            scoreA.text = String(format: "%d", scoreA.text.toInt()! * -1)
        }else if(scoreB.isFirstResponder()){
            scoreB.text = String(format: "%d", scoreB.text.toInt()! * -1)
        }else if(scoreC.isFirstResponder()){
            scoreC.text = String(format: "%d", scoreC.text.toInt()! * -1)
        }else if(scoreD.isFirstResponder()){
            scoreD.text = String(format: "%d", scoreD.text.toInt()! * -1)
        }else if(scoreE.isFirstResponder()){
            scoreE.text = String(format: "%d", scoreE.text.toInt()! * -1)
        }
        sumScore.text = getSumScore() as String
    
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellId: NSString = "Cell"
        var cell: myCell = tableView.dequeueReusableCellWithIdentifier(cellId as String) as! myCell
        cell.cellScoreA.text = arrScore.objectAtIndex(indexPath.row).objectAtIndex(0) as? String
        cell.cellScoreB.text = arrScore.objectAtIndex(indexPath.row).objectAtIndex(1) as? String
        cell.cellScoreC.text = arrScore.objectAtIndex(indexPath.row).objectAtIndex(2) as? String
        cell.cellScoreD.text = arrScore.objectAtIndex(indexPath.row).objectAtIndex(3) as? String
        cell.cellScoreE.text = arrScore.objectAtIndex(indexPath.row).objectAtIndex(4) as? String
        return cell
    }

    func tableView(tableView: UITableView,numberOfRowsInSection section: Int) -> Int{
        return arrScore.count
    }
    
    
//    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete
//    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        arrScore.removeObjectAtIndex(indexPath.row)
        m_tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        var def = NSUserDefaults.standardUserDefaults()
        def.setObject(arrScore, forKey: "arrData")
        def.synchronize()
        updateTitle()
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,forRowAtIndexPath indexPath: NSIndexPath)
    {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset.left = CGFloat(0.0)
        }
        if tableView.respondsToSelector("setLayoutMargins:") {
            tableView.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins.left = CGFloat(0.0)
        }
    }
    

    
    func bannerViewDidLoadAd(banner: ADBannerView!){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            banner.alpha = 1
        })
    }
    
    func bannerView(banner: ADBannerView!,
        didFailToReceiveAdWithError error: NSError!){
            
            banner.alpha = 0
            
    }
    
//    func bannerViewActionShouldBegin(banner: ADBannerView!,
//        willLeaveApplication willLeave: Bool) -> Bool{
//            
//        return true
//    }
//    
//    func bannerViewActionDidFinish(banner: ADBannerView!){
//    
//    }
    
    
    
//    func bannerViewActionShouldBegin(banner: ADBannerView!,
//        willLeaveApplication willLeave: Bool) -> Bool{
//            
//        return true
//    
//    }
}



class myCell:UITableViewCell {
    
    @IBOutlet weak var cellScoreA: UILabel!
    @IBOutlet weak var cellScoreB: UILabel!
    @IBOutlet weak var cellScoreC: UILabel!
    @IBOutlet weak var cellScoreD: UILabel!
    @IBOutlet weak var cellScoreE: UILabel!

}




