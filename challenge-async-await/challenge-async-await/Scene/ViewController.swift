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
				print("fail ㅋㅋ")
			}
		}
	}

}
