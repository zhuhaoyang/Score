//
//  AppDelegate.swift
//  棋牌计分
//
//  Created by Myth on 15/6/19.
//  Copyright (c) 2015年 Myth. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //友盟统计
        MobClick.startWithAppkey("55c032ff67e58eb3f6000cc5", reportPolicy:BATCH, channelId:nil)
        
        let version:NSString = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! NSString
        MobClick.setAppVersion(version as String)
        
        
        //友盟社会化分享
        UMSocialData.setAppKey("55c032ff67e58eb3f6000cc5")
        
        UMSocialWechatHandler.setWXAppId("wx5b4d8e93348a1687", appSecret: "666daa8e10d2cb2ad65e5c616e8f7580", url:"https://itunes.apple.com/cn/app/qi-pai-ji-fen-ma-jiang-pu/id1021525866?ls=1&mt=8")

//        WXApi.registerApp("wx5b4d8e93348a1687", withDescription: version as String)
        return true
    }
    

    //友盟回调
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

