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
				let d = try await fetchMemesData()
				print(d)
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

			return verifyResponse(data: data, response: response)
		} else {
			// Fallback on earlier versions
			return .failure(NetworkError.versionError)
		}
	}

	func verifyResponse(data: Data, response: URLResponse) -> Result<Data, Error> {
		guard let response = response as? HTTPURLResponse else { return .failure(NetworkError.unknown) }

		switch response.statusCode {
		case 200...299:
			return .success(data)
		case 400...499:
			return .failure(NetworkError.invalidRequest)
		case 500...599:
			return .failure(NetworkError.serverError)
		default:
			return .failure(NetworkError.unknown)
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
				throw error
			}

		} catch {
			throw NetworkError.invalidResponse
		}
	}
}
