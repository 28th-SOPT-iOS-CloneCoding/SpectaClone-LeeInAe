//
//  NetworkResponse.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import Foundation

// MARK: - NetworkResponse

struct BaseResponse<T: Decodable>: Decodable {
	let success: Bool
	let data: T
}
