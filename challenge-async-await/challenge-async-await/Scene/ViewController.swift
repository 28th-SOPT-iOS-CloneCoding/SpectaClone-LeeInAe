//
//  ViewController.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()

		Task {
			do {
				try await fetchMemesData()
			} catch {
				print("fail ㅋㅋ")
			}
		}
	}

	func setupUI() {
		view.backgroundColor = .white
	}

	func get(request: URLRequest) async throws -> Result<Data, Error> {
		if #available(iOS 15.0, *) {
			/// response: URLResponse (The metadata associated with the response)
			let (data, response) = try await URLSession.shared.data(for: request)

			print(data)
			print(response)
			return .success(data)
		} else {
			// Fallback on earlier versions
			return .failure(NetworkError.versionError)
		}
	}

	func fetchMemesData() async throws -> BaseResponse<Memes> {
		do {
			guard let url = URL(string: "https://api.imgflip.com/get_memes") else { throw NetworkError.invalidURL }
			let request = URLRequest(url: url)

			let response = try await get(request: request)

			switch response {
			case .success(let data):
				return try JSONDecoder().decode(BaseResponse<Memes>.self, from: data)
			case .failure(let error):
				print(error)
				throw error
			}

		} catch {
			throw NetworkError.invalidResponse
		}
	}
}
