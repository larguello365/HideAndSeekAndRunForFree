//
//  PageSixViewController.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import UIKit
import AVFoundation

class PageSixViewController: UIViewController {
    @IBOutlet var playButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var pageSixText: UILabel!
    @IBOutlet var tapToShootArea: UIView! // tap the tip of the gun held by the union soldier
    
    var pageText: String = ""
    let synthesizer = AVSpeechSynthesizer()
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let tapToPlayEnabled = defaults.bool(forKey: "tapToPlay")
        let automaticEnabled = defaults.bool(forKey: "automatic")
        pageText = pageSixText.text ?? ""
        
        synthesizer.delegate = self
        
        playButton.isHidden = !tapToPlayEnabled
        playButton.addTarget(self, action: #selector(playSpeech), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        if automaticEnabled {
            let voice = AVSpeechSynthesisVoice(language: "en_US")
            let utterance = AVSpeechUtterance(string: pageText)
            utterance.voice = voice
            synthesizer.speak(utterance)
        }
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior = UIGravityBehavior()
        collisionBehavior = UICollisionBehavior()
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGunTap(_:)))
        tapToShootArea.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UINavigationController(rootViewController: homeVC)
            window.makeKeyAndVisible()
        }
    }
    
    @objc func playSpeech() {
        let voice = AVSpeechSynthesisVoice(language: "en_US")
        let utterance = AVSpeechUtterance(string: pageText)
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    @objc func handleGunTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.view)
        let bullet = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        showMuzzleFlash(at: tapLocation)
        
        bullet.backgroundColor = .orange
        bullet.layer.cornerRadius = 7.5
        bullet.center = tapLocation
        self.view.addSubview(bullet)

        gravityBehavior.addItem(bullet)
        collisionBehavior.addItem(bullet)

        let pushBehavior = UIPushBehavior(items: [bullet], mode: .instantaneous)
        pushBehavior.angle = -.pi / 2
        pushBehavior.magnitude = 1.5
        animator.addBehavior(pushBehavior)
        
        playShot()
    }
    
    func showMuzzleFlash(at point: CGPoint) {
        let flash = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        flash.backgroundColor = .yellow
        flash.layer.cornerRadius = 15
        flash.center = point
        flash.alpha = 0
        self.view.addSubview(flash)

        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            flash.alpha = 1
            flash.transform = CGAffineTransform(scaleX: 2, y: 2)
        }

        animator.addCompletion { _ in
            flash.removeFromSuperview()
        }

        animator.startAnimation()
    }
    
    func playShot() {
        guard let path = Bundle.main.path(forResource: "gun-shot", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension PageSixViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Started")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let attributed = NSMutableAttributedString(string: pageText)
        
        // Make all text white first
        attributed.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributed.length))
        
        // Highlight the currently spoken range in red
        attributed.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        
        DispatchQueue.main.async {
            self.pageSixText.attributedText = attributed
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let fullText = NSAttributedString(string: pageText, attributes: [.foregroundColor: UIColor.white])
        DispatchQueue.main.async {
            self.pageSixText.attributedText = fullText
        }
    }
}
