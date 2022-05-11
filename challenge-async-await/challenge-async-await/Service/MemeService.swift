//
//  MemeService.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/12.
//

import Foundation

struct MemeService {
	static let shared = MemeService()
	static let url = ApiManager.baseURL + "/get_memes"

	private init() {}

	func fetchMemesData() async throws -> BaseResponse<Memes> {
		guard let url = URL(string: Self.url) else { throw NetworkError.invalidURL }
		let request = URLRequest(url: url)

		do {
			let response = try await ApiManager.shared.requestData(request: request)

			// TODO: - 여기도 분리하고싶어

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
