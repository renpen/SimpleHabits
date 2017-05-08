//
//  SpotifyCore.swift
//  AlarmClock
//
//  Created by René Penkert on 08.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation

class SpotifyCore : NSObject, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    var auth = SPTAuth.defaultInstance()!
    var seesion : SPTSession!
    var player: SPTAudioStreamingController?
    var login:URL?
    static let sharedInstance = SpotifyCore()
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(SpotifyCore.updateAfterLogin), name: Notification.Name("loginSuccessfull"), object: nil)
    }
    func setup() {
        SPTAuth.defaultInstance().clientID = "8aff7bb8dbc743859ad7535f445ba9d8"
        SPTAuth.defaultInstance().redirectURL = URL(string: "AlarmClock://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope,SPTAuthPlaylistReadPrivateScope,SPTAuthPlaylistModifyPublicScope,SPTAuthPlaylistModifyPrivateScope]
        self.login = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    }
    func spotifyAuth() {
        if UIApplication.shared.openURL(self.login!) {
            if auth.canHandle(auth.redirectURL) {
                print("SpotifyAUTH")
            }
        }
    }
    func updateAfterLogin()
    {
        print("UpdateAfterLogin")
        if let sessionObj: AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject
        {
            print("sessionObj != nil")
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.seesion = firstTimeSession
            initializePlayer(authSession: seesion)
        }
    }
    func initializePlayer(authSession : SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player!.start(withClientId: auth.clientID)
            self.player?.login(withAccessToken: authSession.accessToken)
        }
    }
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        print("Logged in")
        self.player?.playSpotifyURI("spotify:track:6sqNctd7MlJoKDOxPVCAvU", startingWith: 0, startingWithPosition: 0, callback: {
            (error) in
            if error != nil
            {
                print("Playing")
            }
            print("Error in Playing : \(error)")
        })
    }
}

