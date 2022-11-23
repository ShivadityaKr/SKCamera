//
//  PhotoViewController.swift
//  SKCamera
//
//  Created by Shivaditya Kumar on 2022-11-22.
//


import UIKit

class PhotoViewController: UIViewController {

	override var prefersStatusBarHidden: Bool {
		return true
	}

	private var backgroundImage: UIImage

	init(image: UIImage) {
		self.backgroundImage = image
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.gray
		let backgroundImageView = UIImageView(frame: view.frame)
		backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFit
		backgroundImageView.image = backgroundImage
		view.addSubview(backgroundImageView)
	}
}
