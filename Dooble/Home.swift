/* =======================

- DOOBLE -

created by FV iMAGINATION © 2015
All rights reserved
http://fvimagination.com

=========================*/


import UIKit
import AudioToolbox
import GameKit


class Home: UIViewController,
GKGameCenterControllerDelegate
{

    /* Views */
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var bestScoreLabel: UILabel!

    
    /* Variables */
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    
    
override func prefersStatusBarHidden() -> Bool {
        return true
}
override func viewDidLoad() {
        super.viewDidLoad()
    
    // Call the GC authentication controller
    authenticateLocalPlayer()
    
    // Round logo image
    logoImage.layer.cornerRadius = 20
    logoImage.layer.borderColor = UIColor.whiteColor().CGColor
    logoImage.layer.borderWidth = 2

    
    // Show Best Score
    if bestScore != 0 {  bestScoreLabel.text = "Best: \(bestScore)"  }
    else {  bestScoreLabel.text = "Best: 0"  }
        
}

    
// MARK: - AUTHENTICATE GAME CENTER PLAYER
func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.presentViewController(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.authenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifer: String?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error)
            }
            
        }
}
func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
}
    

    

// MARK: - PLAY BUTTON
@IBAction func playButt(sender: AnyObject) {
    playSound("tap", type:"mp3")
}
    

    
// MARK: - GAME CENTER BUTTON
@IBAction func gcButt(sender: AnyObject) {
    playSound("tap", type:"mp3")

    let gcVC: GKGameCenterViewController = GKGameCenterViewController()
    gcVC.gameCenterDelegate = self
    gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
    gcVC.leaderboardIdentifier = LEADERBOARD_ID
    self.presentViewController(gcVC, animated: true, completion: nil)
}
    
    
    
// MARK: - SHARE BEST SCORE BUTTON
@IBAction func shareButt(sender: AnyObject) {
    playSound("tap", type:"mp3")

    let shareItems:Array = [bestScoreMess, logoImage.image!]
    let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
    activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
    
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        // iPad
        let popOver = UIPopoverController(contentViewController: activityViewController)
        activityViewController.preferredContentSize = CGSizeMake(view.frame.size.width-320, view.frame.size.height-450)
        popOver.presentPopoverFromRect(CGRectMake(400, 400, 0, 0), inView: self.view, permittedArrowDirections: UIPopoverArrowDirection(), animated: true)
    } else {
        // iPhone
        presentViewController(activityViewController, animated: true, completion: nil)
    }
}
    
   
    
// MARK: - PLAY SOUND
func playSound(soundName: String, type: String) {
    let filePath = NSBundle.mainBundle().pathForResource(soundName, ofType: type)
    soundURL = NSURL(fileURLWithPath: filePath!)
    AudioServicesCreateSystemSoundID(soundURL!, &soundID)
    AudioServicesPlaySystemSound(soundID)
}
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
