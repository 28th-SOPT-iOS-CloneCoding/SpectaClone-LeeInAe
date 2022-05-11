//
//  APIManager.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/12.
//

import Foundation

struct ApiManager {
	static let shared = Self.init() /// 굳이 ... ?
	static let baseURL = "https://api.imgflip.com"
	
	func requestData(request: URLRequest) async throws -> Result<Data, Error> {
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
}