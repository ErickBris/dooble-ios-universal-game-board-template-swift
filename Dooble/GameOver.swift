/* =======================

- DOOBLE -

created by FV iMAGINATION © 2015
All rights reserved
http://fvimagination.com

=========================*/


import UIKit
import AudioToolbox
import GameKit


class GameOver: UIViewController,
GKGameCenterControllerDelegate
{

    /* Views */
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var bestScoreLabel: UILabel!
    
    
override func prefersStatusBarHidden() -> Bool {
        return true
}
override func viewDidLoad() {
        super.viewDidLoad()

    scoreLabel.text = "Score: \(score)"
    bestScoreLabel.text = "Best: \(bestScore)"
    
    
    submitBestScore()
    
}


    
// HOME BUTTON
@IBAction func homeButt(sender: AnyObject) {
    playSound("tap", type: "mp3")

    let hVC = storyboard?.instantiateViewControllerWithIdentifier("Home") as! Home
    navigationController?.pushViewController(hVC, animated: true)
}
    

// GAME CENTER BUTTON
@IBAction func gcButt(sender: AnyObject) {
    playSound("tap", type: "mp3")
    
    let gcVC: GKGameCenterViewController = GKGameCenterViewController()
    gcVC.gameCenterDelegate = self
    gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
    gcVC.leaderboardIdentifier = LEADERBOARD_ID
    self.presentViewController(gcVC, animated: true, completion: nil)
}


// Submit Best Score to Game Center's LEADERBOARD
func submitBestScore() {
    let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
    bestScoreInt.value = Int64(bestScore)
   // let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    GKScore.reportScores([bestScoreInt], withCompletionHandler: { (error: NSError?) -> Void in
        if error != nil {
            print(error!.localizedDescription)
        } else {
            print("Best Score submitted to your Leaderboard!")
        }
    })
}
func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
}

    
    
// PLAY AGAIN BUTTON
@IBAction func playAgainButt(sender: AnyObject) {
    playSound("tap", type: "mp3")
    navigationController?.popViewControllerAnimated(true)
}
    
// SHARE SCORE BUTTON
@IBAction func shareScoreButt(sender: AnyObject) {
    playSound("tap", type: "mp3")
    
    let logoImg: UIImage = UIImage(named: "logo")!
    let shareItems:Array = [scoreMess, logoImg]
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

    
  
// PLAY SOUND
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
