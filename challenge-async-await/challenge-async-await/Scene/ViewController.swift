//
//  ViewController.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {
	private let memeService: MemeService = .shared

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		fetchMemesData()
	}

	func setupUI() {
		view.backgroundColor = .white
	}

	func fetchMemesData() {
		Task {
			do {
				try await memeService.fetchMemesData()
			} catch {
				presentAlert(message: error.localizedDescription)
			}
		}
	}

	func presentAlert(message: String) {
		let alert = UIAlertController(title: "잠깐만요!", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)

		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
}
