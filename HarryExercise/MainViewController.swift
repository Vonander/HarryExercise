//
//  BookViewController.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-12.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    private lazy var tableView = UITableView()
    private lazy var bookResults = ApiPayload(items: [])
    private lazy var apiHandler = ApiHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.title
        configureTableView()

        fetchBooks()
    }

    func fetchBooks() {
        apiHandler.fetchBooksJSON { (bookResults, error) in

            if let error = error  {
                print("Failed to fetch books: ", error)

                return
            }

            guard let bookResults = bookResults else { return }

            self.bookResults = bookResults

            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()

        tableView.rowHeight = 100
        tableView.register(BookCell.self, forCellReuseIdentifier: Constants.bookCell)
        tableView.pin(to: view)
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookResults.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bookCell) as! BookCell

        cell.titleLabel.text = bookResults.items[indexPath.row].title
        cell.coverImage.load(urlString: bookResults.items[indexPath.row].cover.url)

        return cell
    }
}
