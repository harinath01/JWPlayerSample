//
//  ViewController.swift
//  sampleJWPlayerApp
//
//  Created by Testpress on 25/11/23.
//

import UIKit
import JWPlayerKit

public class ViewController: JWPlayerViewController {
    var totalVideoDuration: Double = 0
    var currentPosition: Double = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.launchJWPlayer()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
        currentPosition = self.player.time.position
    }
    
    private func launchJWPlayer() {
        delegate = self
        self.forceLandscapeOnFullScreen = true
        self.forceFullScreenOnLandscape = false
        if let videoURL = URL(string: "https://cdn.jwplayer.com/manifests/gDCZ3Jae.m3u8") {
            do {
                let item = try JWPlayerItemBuilder()
                    .file(videoURL)
                    .startTime(0)
                    .build()

                let config = try JWPlayerConfigurationBuilder()
                    .playlist(items: [item])
                    .autostart(true)
                    .build()
                player.configurePlayer(with: config)
            } catch {
                print(error)
                return
                
            }
        }
        
    }
    
    override public func jwplayer(_ player: JWPlayer, isPlayingWithReason reason: JWPlayReason) {
        super.jwplayer(player, isPlayingWithReason: reason)
        
        self.totalVideoDuration = player.time.duration
    }
    
    override public func jwplayer(_ player: JWPlayer, didPauseWithReason reason: JWPauseReason) {
        super.jwplayer(player, didPauseWithReason: reason)
        print(reason)
        
        currentPosition = player.time.position
    }
    
    override public func jwplayerContentDidComplete(_ player: JWPlayer) {
        super.jwplayerContentDidComplete(player)
        currentPosition = player.time.duration
    }
    
    override public func onMediaTimeEvent(_ time: JWTimeData) {
        super.onMediaTimeEvent(time)
        currentPosition = player.time.position
    }
    
    public func stop() {
        player.pause()
    }
}

extension ViewController: JWPlayerViewControllerDelegate {
    public func playerViewControllerDidDismissFullScreen(_ controller: JWPlayerKit.JWPlayerViewController) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, controlBarVisibilityChanged isVisible: Bool, frame: CGRect) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, sizeChangedFrom oldSize: CGSize, to newSize: CGSize) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, screenTappedAt position: CGPoint) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedMenuOpenedWithItems items: [JWPlayerKit.JWPlayerItem], withMethod method: JWPlayerKit.JWRelatedInteraction) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedMenuClosedWithMethod method: JWPlayerKit.JWRelatedInteraction) {}
    
    public func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedItemBeganPlaying item: JWPlayerKit.JWPlayerItem, atIndex index: Int, withMethod method: JWPlayerKit.JWRelatedMethod) {}
    
    public func playerViewControllerWillGoFullScreen(_ controller: JWPlayerViewController) -> JWFullScreenViewController? {
        return PlayerFullScreenViewController()
    }
    
    public func playerViewControllerDidGoFullScreen(_ controller: JWPlayerViewController) {
        self.player.play()
    }
    
    public func playerViewControllerWillDismissFullScreen(_ controller: JWPlayerViewController) {
       if self.player.playbackRate == 0.0 {

       } else {
           self.player.play()
       }
    }
}
