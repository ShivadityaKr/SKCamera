//
//  ViewController.swift
//  SKCamera
//
//  Created by Shivaditya Kumar on 2022-11-22.
//

import UIKit
import AVFoundation

class ViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {

    @IBOutlet weak var captureButton: SwiftyRecordButton!
    @IBOutlet weak var flipCameraButton : UIButton!
    @IBOutlet weak var flashButton      : UIButton!
    @IBOutlet weak var cameraSegment: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    var videoTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        flashMode = .auto
        flashButton.setImage(#imageLiteral(resourceName: "flashauto"), for: UIControl.State())
        captureButton.buttonEnabled = false
        setUI()
    }
    private func setUI() {
        // ImageView
        self.imageView.layer.cornerRadius = 5
        self.imageView.layer.shadowRadius = 5
        self.imageView.layer.shadowColor = UIColor.black.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        // Segment
        self.cameraSegment.addTarget(self, action: #selector(didSegmentChange), for: .valueChanged)
        // TimeLabel
        self.timerLabel.text = ""
        self.timerLabel.font = .systemFont(ofSize: 18)
        self.timerLabel.alpha = 0.0
    }
    @objc func didSegmentChange() {
        if self.cameraSegment.selectedSegmentIndex == 0 {
//            self.captureButton.shrinkButton()
            self.captureButton.cameraMode = .photo
        } else {
//            self.captureButton.growButton()
            self.captureButton.cameraMode = .video
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let image = self.imageView.image {
            let newVC = PhotoViewController(image: image)
            self.present(newVC, animated: true, completion: nil)
        }
    }
 
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did start running")
        captureButton.buttonEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did stop running")
        captureButton.buttonEnabled = false
    }
    

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        self.imageView.image = photo
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        self.videoTimer.invalidate()
        self.videoTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(didTimeUpdated), userInfo: nil, repeats: true)
        captureButton.growButton()
        self.timerLabel.alpha = 1.0
        hideButtons()
    }
    var timeCount = 0 {
        didSet {
            self.timerLabel.text = timeCount < 10 ? "00:0\(timeCount)" : "00:\(timeCount)"
        }
    }
    @objc func didTimeUpdated() {
        self.timeCount += 1
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        videoTimer.invalidate()
        captureButton.shrinkButton()
        self.timeCount = 0
        self.timerLabel.alpha = 0.0
        showButtons()
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
        self.present(newVC, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        print("Did focus at point: \(point)")
        focusAnimationAt(point)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print("Zoom level did change. Level: \(zoom)")
        print(zoom)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print("Camera did change to \(camera.rawValue)")
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }

    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
    @IBAction func toggleFlashTapped(_ sender: Any) {
        //flashEnabled = !flashEnabled
        toggleFlashAnimation()
    }

}
// UI Animations
extension ViewController {
    
    fileprivate func hideButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
            self.imageView.alpha = 0.0
            self.cameraSegment.alpha = 0.0
        }
    }
    
    fileprivate func showButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
            self.imageView.alpha = 1.0
            self.cameraSegment.alpha = 1.0
        }
    }
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func toggleFlashAnimation() {
        //flashEnabled = !flashEnabled
        if flashMode == .auto{
            flashMode = .on
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControl.State())
        }else if flashMode == .on{
            flashMode = .off
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControl.State())
        }else if flashMode == .off{
            flashMode = .auto
            flashButton.setImage(#imageLiteral(resourceName: "flashauto"), for: UIControl.State())
        }
    }
}

