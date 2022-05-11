//
//  Memes.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import Foundation

// MARK: - Memes

struct Memes: Codable {
	let memes: [Meme]
}

// MARK: - Meme

struct Meme: Codable {
	let id, name: String
	let url: String
	let width, height, boxCount: Int

	enum CodingKeys: String, CodingKey {
		case id, name, url, width, height
		case boxCount = "box_count"
	}
}
