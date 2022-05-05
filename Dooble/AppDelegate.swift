/* =======================

 - DOOBLE -

created by FV iMAGINATION © 2015
All rights reserved
http://fvimagination.com

=========================*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
   
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {
        adIsFullScreen = false
        print("FULL SCREEN: \(adIsFullScreen)")
    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

