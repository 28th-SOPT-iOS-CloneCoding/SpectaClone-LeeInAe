//
//  ImageDownloader.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/06/03.
//

import Foundation
import UIKit

class ImageDownloader {
    typealias Image = UIImage
    static let shared = ImageDownloader()
    private var cache: [URL: Image] = [:]

    private init() {}

    func image(from url: URL) async throws -> Image? {
        if let image = cache[url] {
            return image
        }

        let image = try await fetchImage(from: url)
        self.cache[url] = image

        return image
    }

    func fetchImage(from url: URL) async throws -> Image {
        if #available(iOS 15.0, *) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.notOK }

            guard let image = UIImage(data: data) else { throw ImageError.badImage }
            return image
        } else {
            // Fallback on earlier versions
            throw NetworkError.versionError
        }
    }

    func logCache() {
        print(self.cache)
    }
}
