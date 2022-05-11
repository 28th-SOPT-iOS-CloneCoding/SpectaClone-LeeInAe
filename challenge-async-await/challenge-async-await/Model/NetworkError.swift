//
//  NetworkError.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import Foundation

enum NetworkError: Error {
	case invalidResponse
	case parsingError
	case versionError
	case invalidURL
}
