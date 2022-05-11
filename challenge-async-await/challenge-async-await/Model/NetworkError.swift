//
//  NetworkError.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import Foundation

enum NetworkError: Error {
	case versionError
	case invalidURL

	case invalidResponse
	case parsingError
	case invalidRequest
	case serverError
	case unknown
}

enum FetchError: Error {
	case notOK
	case badData
}
