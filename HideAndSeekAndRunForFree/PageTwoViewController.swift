//
//  PageTwoViewController.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import UIKit
import AVFoundation

class PageTwoViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var pageTwoText: UILabel!
    
    var pageText: String = ""
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let tapToPlayEnabled = defaults.bool(forKey: "tapToPlay")
        let automaticEnabled = defaults.bool(forKey: "automatic")
        pageText = pageTwoText.text ?? ""
        
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
    
}

extension PageTwoViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Started")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let attributed = NSMutableAttributedString(string: pageText)
        
        // Make all text black first
        attributed.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributed.length))
        
        // Highlight the currently spoken range in red
        attributed.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        
        DispatchQueue.main.async {
            self.pageTwoText.attributedText = attributed
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let fullText = NSAttributedString(string: pageText, attributes: [.foregroundColor: UIColor.white])
        DispatchQueue.main.async {
            self.pageTwoText.attributedText = fullText
        }
    }
}
