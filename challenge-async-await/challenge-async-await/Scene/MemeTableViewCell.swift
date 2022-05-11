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

		return label
	}()

	let thumbnailView: UIImageView = {
		let image = UIImageView()

		return image
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		
		setupUI()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	func setupUI() {
		addSubview(nameLabel)
		addSubview(thumbnailView)
		
		thumbnailView.snp.makeConstraints { make in
			make.size.equalTo(250)
			make.top.bottom.equalToSuperview().inset(20)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.leading.equalTo(thumbnailView.snp.trailing).offset(20)
			make.centerY.equalToSuperview()
		}
	}
}
