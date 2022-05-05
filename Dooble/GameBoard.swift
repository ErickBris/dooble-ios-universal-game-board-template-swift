/* =======================

- DOOBLE -

created by FV iMAGINATION © 2015
All rights reserved
http://fvimagination.com

=========================*/


import UIKit
import AudioToolbox
import GoogleMobileAds


class GameBoard: UIViewController,
GADBannerViewDelegate
{

    /* Views */
    @IBOutlet var centerDot: UIView!
    @IBOutlet var scoreLabel: UILabel!

    var adMobBannerView = GADBannerView()
    
    
    
    /* Variables */
    var fireDotsTimer = NSTimer()
    var timeInterval = NSTimeInterval()
    var dotIsBlack = false
    var isGameOver = false
    
    
    
    
    
override func prefersStatusBarHidden() -> Bool {
    return true
}
override func viewWillAppear(animated: Bool) {
    
    // Init ad banner
    initAdMobBanner()
    
    // Set initial Time Interval for firing new dots
    timeInterval = 1.5
    
    // Reset score
    score = 0
    scoreLabel.text = "0"
    
    // Reset Booleans
    isGameOver = false
    adIsFullScreen = false
    dotIsBlack = false

    // Set center Dot initially White
    setDotWhite()
    
    // Prepare timer to fire dots
    setFireDotTimer()
    
    
    // CONSOLE LOGS:
   // println("GAME OVER: \(isGameOver)\n TIME INTERV.: \(timeInterval)\n  dotIsBlack: \(dotIsBlack)")
}
    
    
override func viewDidLoad() {
        super.viewDidLoad()

    // Center the Dot
    centerDot.center = view.center
    
}

func setFireDotTimer()  {
    if !isGameOver {
    fireDotsTimer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(fireDots), userInfo: nil, repeats: true)
    }
}

  
// MARK: - SETUP THE BIG DOT IN THE CENTER OF THE SCREEN
func setDotWhite() {
    centerDot.layer.cornerRadius = centerDot.bounds.size.width/2
    centerDot.layer.borderColor = darkGray.CGColor
    centerDot.layer.borderWidth = 3
    centerDot.backgroundColor = UIColor.clearColor()
    scoreLabel.textColor = darkGray
}
func setDotBlack() {
    centerDot.backgroundColor = darkGray
    scoreLabel.textColor = white
}

    
    
    
// FIRE DOTS METHOD
func fireDots() {
    
    // ENEMY DOTS CONFIGURATION
    let upperDot = UIView(frame: CGRectMake(0, 0, 30, 30))
    upperDot.center = CGPointMake(view.frame.size.width/2, 0)
    upperDot.clipsToBounds = true
    upperDot.layer.cornerRadius = upperDot.bounds.size.width/2
    upperDot.layer.borderColor = darkGray.CGColor
    upperDot.layer.borderWidth = 2
    
    let lowerDot =  UIView(frame: CGRectMake(0, 0, 30, 30))
    lowerDot.center = CGPointMake(view.frame.size.width/2, view.frame.size.height + 30)
    lowerDot.clipsToBounds = true
    lowerDot.layer.cornerRadius = lowerDot.bounds.size.width/2
    lowerDot.layer.borderColor = darkGray.CGColor
    lowerDot.layer.borderWidth = 2
    
    
    
    // GENERATE A RANDOM DOT
    let randomDot = Int(arc4random() % 2)

    switch randomDot {
    
    // UPPER DOT
    case 0:
        if !adIsFullScreen {
            
        let randomColor = Int(arc4random() % 2)
        if randomColor == 0 { upperDot.backgroundColor = UIColor.clearColor()
        } else { upperDot.backgroundColor = darkGray  }
        view.addSubview(upperDot)
            
        if isGameOver || adIsFullScreen  { upperDot.removeFromSuperview() }
        
    UIView.animateWithDuration(timeInterval, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
        upperDot.frame.origin.y = self.centerDot.frame.origin.y - 30
        
        
        
        
    // DOT HITS THE CENTER
    }, completion: { (finished: Bool) in
        
        // Add Score
        if randomColor == 0  &&  !self.dotIsBlack ||
        randomColor == 1  &&  self.dotIsBlack {
        if !self.isGameOver {  self.addScorePoint() }
        
        // Game Over
        } else {
            if !self.isGameOver { self.playSound("gameOver", type: "wav")
                self.gameOver()
                self.isGameOver = true
            }
            //println("game over1")
        }
            
        upperDot.removeFromSuperview()
        })
    
    }
    break
        
        
        
        
    // LOWER DOT
    case 1:
        if !adIsFullScreen {
            
        let randomColor = Int(arc4random() % 2)
        if randomColor == 0 {  lowerDot.backgroundColor = UIColor.clearColor()
        } else {  lowerDot.backgroundColor = darkGray  }
        view.addSubview(lowerDot)
        
        if isGameOver || adIsFullScreen { lowerDot.removeFromSuperview() }
        
    UIView.animateWithDuration(timeInterval, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
        lowerDot.frame.origin.y = self.centerDot.frame.origin.y + self.centerDot.frame.size.height
            
    // DOT HITS THE CENTER
    }, completion: { (finished: Bool) in
       
        // Add Score
        if randomColor == 0  &&  !self.dotIsBlack ||
        randomColor == 1  &&  self.dotIsBlack {
        if !self.isGameOver {  self.addScorePoint() }
        
        // Game Over
        } else {
            if !self.isGameOver {
                self.playSound("gameOver", type: "wav")
                self.gameOver()
                self.isGameOver = true
            }
            //println("game over2")
        }
            
        lowerDot.removeFromSuperview()
        })
    
    }
    break
        
    default:break  }
    
    
    if !isGameOver && !adIsFullScreen {  playSound("dot", type: "wav")  }
    setTimeInterval()
    
}

    
// MARK: - SET DIFFERENT TIME INTERVALS BASED ON THE REACHED SCORE
func setTimeInterval() {

    // Here you can edit the blue values as you wish: 
    // The CASE values are the score points you reach while playing
    // timeInterval values are the amount in seconds when the fireDotTimer will get updated
    switch score {
        
    case 5:  timeInterval = 1.2
    fireDotsTimer.invalidate()
    if !isGameOver {  setFireDotTimer()  }
        break
    case 10: timeInterval = 0.9
    fireDotsTimer.invalidate()
    if !isGameOver {  setFireDotTimer()  }
        break
    case 15: timeInterval = 0.7
    fireDotsTimer.invalidate()
    if !isGameOver {  setFireDotTimer()  }
        break
    case 20: timeInterval = 0.5
    fireDotsTimer.invalidate()
    if !isGameOver {  setFireDotTimer()  }
        break
    
    default:break }
    
}

    
func addScorePoint() {
    score += 1
    scoreLabel.text = "\(score)"
}
  
    
    
// MARK: - TOUCH THE SCREEN TO SWITCH CENTER DOT'S COLORS
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    playSound("tap", type: "mp3")
    
    dotIsBlack = !dotIsBlack
    if dotIsBlack {  setDotBlack()
    } else {  setDotWhite()  }
}
    
    
    
    
    
// MARK: - GAME OVER!!
func gameOver() {
    if bestScore < score {
        bestScore = score
        defaults.setInteger(bestScore, forKey: "bestScore")
    }
    
    print("GAME OVER: \(isGameOver)")
    
    fireDotsTimer.invalidate()
    view.layer.removeAllAnimations()
    
    let goVC = storyboard?.instantiateViewControllerWithIdentifier("GameOver") as! GameOver
    navigationController?.pushViewController(goVC, animated: true)
}


    
// MARK: - BACK BUTTON
@IBAction func backButt(sender: AnyObject) {
    isGameOver = true
    playSound("tap", type: "mp3")
    fireDotsTimer.invalidate()
    
    navigationController?.popViewControllerAnimated(true)
}
    
    
    
// MARK: - PLAY SOUND
func playSound(soundName: String, type: String) {
    let filePath = NSBundle.mainBundle().pathForResource(soundName, ofType: type)
    soundURL = NSURL(fileURLWithPath: filePath!)
    AudioServicesCreateSystemSoundID(soundURL!, &soundID)
    AudioServicesPlaySystemSound(soundID)
}
  

    
    
    
    
    
    
// MARK: - AdMob BANNERS
func initAdMobBanner() {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            // iPad banner
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSizeMake(728, 90))
            adMobBannerView.frame = CGRectMake(0, self.view.frame.size.height, 728, 90)
        } else {
            // iPhone banner
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSizeMake(320, 50))
            adMobBannerView.frame = CGRectMake(0, self.view.frame.size.height, 320, 50)
        }

        adMobBannerView.adUnitID = ADMOB_UNIT_ID
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
        adMobBannerView.loadRequest(request)
    }
    
    
    // Hide the banner
    func hideBanner(banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRectMake(0, view.frame.size.height, banner.frame.size.width, banner.frame.size.height)
        UIView.commitAnimations()
        banner.hidden = true
        
    }
    
    // Show the banner
    func showBanner(banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRectMake(view.frame.size.width/2 - banner.frame.size.width/2, view.frame.size.height - banner.frame.size.height,
            banner.frame.size.width, banner.frame.size.height);
        UIView.commitAnimations()
        banner.hidden = false
        
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("AdMob loaded!")
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("AdMob Can't load ads right now, they'll be available later \n\(error)")
        hideBanner(adMobBannerView)
    }
    
    
    
// DELEGATES TO CONTROL THE GAME WHILE ADS ARE FULL SCREEN
func adViewWillLeaveApplication(adView: GADBannerView!) {
    adIsFullScreen = true
    view.layer.removeAllAnimations()
    print("FULL SCREEN: \(adIsFullScreen)")
}


    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}

