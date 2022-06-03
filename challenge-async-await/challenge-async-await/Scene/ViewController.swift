//
//  ViewController.swift
//  challenge-async-await
//
//  Created by Devsisters on 2022/05/11.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
	private let memeService: MemeService = .shared

	var memes: [Meme] = []

	lazy var tableView: UITableView = {
		let table = UITableView()
        table.rowHeight = 190
		table.delegate = self
		table.dataSource = self
		table.register(MemeTableViewCell.self, forCellReuseIdentifier: String(describing: MemeTableViewCell.self))

		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		fetchMemesData()
	}

	func setupUI() {
		view.backgroundColor = .white

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
        
        let reloadButton = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(didTapReloadButton(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = reloadButton
	}

	func fetchMemesData() {
		Task {
			do {
				let memes = try await memeService.fetchMemesData()
				self.memes = memes.data.memes
				try await Task.sleep(nanoseconds: 3_000_000_000)

				tableView.reloadData()
			} catch {
				presentAlert(message: error.localizedDescription)
			}
		}
	}

	func presentAlert(message: String) {
		let alert = UIAlertController(title: "잠깐만요!", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)

		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
    
    @objc
    func didTapReloadButton(_ sender: UIButton) {
        Task {
            await ImageDownloader.shared.logCache()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		memes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemeTableViewCell.self), for: indexPath) as? MemeTableViewCell else { return UITableViewCell() }

		cell.configCell(meme: memes[indexPath.row])
		return cell
	}
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {}
