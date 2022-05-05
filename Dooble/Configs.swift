/* =======================

- DOOBLE -

created by FV iMAGINATION © 2015
All rights reserved
http://fvimagination.com

=========================*/

import Foundation
import UIKit

import AudioToolbox
var soundURL: NSURL?
var soundID:SystemSoundID = 0


var defaults = NSUserDefaults.standardUserDefaults()
var score = 0
var bestScore = defaults.integerForKey("bestScore")
var adIsFullScreen = false



// IMPORTANT: Replace the red string below with your own AD UNIT ID you've got from www.apps.admob.com
var ADMOB_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"


// CHANGE THE RED STRING BELOW ACCORDINGLY TO THE NAME YOU'LL GIVE TO YOUR OWN VERSION OF THIS APP
var APP_NAME = "DOOBLE"

// CHANGE THE RED STRING BELOW ACCORDINGY TO THE ITUNES APP STORE LINK OF YOUR OWN APP (You cam get it by clicking on More -> About this app on your app's page in iTC)
var APP_STORE_LINK = "https://itunes.apple.com/app/xxxxxxxxxxxxx"

// Replace the red string below with your own Leaderboard ID (the one you've set on your app's page in iTC)
var LEADERBOARD_ID = "com.bestscore.dooble"


// COLORS (You can edit them as you wish by changing their RGB values before "/255.0" )
var darkGray = UIColor(red: 67.0/255.0, green: 74.0/255.0, blue: 84.0/255.0, alpha: 1.0)
var white = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)


// SHARE SCORE MESSAGE (Edit it as you wish but do not change the blue variables)
var scoreMess = "I've just reached \(score) on #\(APP_NAME), check it out - \(APP_STORE_LINK)"

// SHARE BEST SCORE MESSAGE (Edit it as you wish but do not change the blue variables)
var bestScoreMess = "My Best Score on #\(APP_NAME) is \(bestScore), check it out - \(APP_STORE_LINK)"



