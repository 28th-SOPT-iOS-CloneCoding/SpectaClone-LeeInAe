//
//  MemeTableViewCell.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/12.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
	let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 15)
		label.lineBreakMode = .byTruncatingTail

		return label
	}()

	let thumbnailView: UIImageView = {
		let image = UIImageView()

		return image
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setupUI() {
		addSubview(nameLabel)
		addSubview(thumbnailView)

		thumbnailView.snp.makeConstraints { make in
			make.size.equalTo(150)
			make.leading.equalToSuperview().offset(20)
			make.top.bottom.equalToSuperview().inset(20)
		}

		nameLabel.snp.makeConstraints { make in
			make.leading.equalTo(thumbnailView.snp.trailing).offset(20)
			make.trailing.equalToSuperview().offset(-20)
			make.centerY.equalToSuperview()
		}
	}

	func configCell(meme: Meme) {
		nameLabel.text = meme.name

		// FIXME: - cell에서 가져오지말고 view에서 visible될 떄

		Task {
			do {
				thumbnailView.image = try await ApiManager.shared.fetchImage(from: URL(string: meme.url)!)
			} catch {}
		}
	}
}
