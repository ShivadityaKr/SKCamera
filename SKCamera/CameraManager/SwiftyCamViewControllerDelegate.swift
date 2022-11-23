//
//  SwiftyCamViewControllerDelegate.swift
//  SKCamera
//
//  Created by Shivaditya Kumar on 2022-11-22.
//


import UIKit
import AVFoundation

// MARK: Public Protocol Declaration

/// Delegate for SwiftyCamViewController

public protocol SwiftyCamViewControllerDelegate: class {
    
    /**
     SwiftyCamViewControllerDelegate function called when when SwiftyCamViewController session did start running.
     Photos and video capture will be enabled.
     
     - Parameter swiftyCam: Current SwiftyCamViewController
     */
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController)
    
    /**
     SwiftyCamViewControllerDelegate function called when when SwiftyCamViewController session did stops running.
     Photos and video capture will be disabled.
     
     - Parameter swiftyCam: Current SwiftyCamViewController
     */
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController)
    
    /**
     SwiftyCamViewControllerDelegate function called when the takePhoto() function is called.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter photo: UIImage captured from the current session
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage)
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController begins recording video.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter camera: Current camera orientation
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController finishes recording video.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter camera: Current camera orientation
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection)
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController is done processing video.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter url: URL location of video in temporary directory
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL)
    
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController fails to record a video.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter error: An error object that describes the problem
     */
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error)
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController switches between front or rear camera.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter camera: Current camera selection
     */
    
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection)
    
    /**
     SwiftyCamViewControllerDelegate function called when SwiftyCamViewController view is tapped and begins focusing at that point.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter point: Location in view where camera focused
     
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint)
    
    /**
     SwiftyCamViewControllerDelegate function called when when SwiftyCamViewController view changes zoom level.
     
     - Parameter swiftyCam: Current SwiftyCamViewController session
     - Parameter zoom: Current zoom level
     */
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat)
    
    /**
     SwiftyCamViewControllerDelegate function called when when SwiftyCamViewController fails to confiture the session.
     
     - Parameter swiftyCam: Current SwiftyCamViewController
     */
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController)
    
    /**
     SwiftyCamViewControllerDelegate function called when when SwiftyCamViewController does not have access to camera or microphone.
     
     - Parameter swiftyCam: Current SwiftyCamViewController
     */
    
    func swiftyCamNotAuthorized(_ swiftyCam: SwiftyCamViewController)
}

public extension SwiftyCamViewControllerDelegate {
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        // Optional
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        // Optional
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        // Optional
    }

    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        // Optional
    }

    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        // Optional
    }

    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        // Optional
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        // Optional
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        // Optional
    }

    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        // Optional
    }

    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        // Optional
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        // Optional
    }
    
    func swiftyCamNotAuthorized(_ swiftyCam: SwiftyCamViewController) {
        // Optional
    }
}



