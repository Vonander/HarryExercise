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

        configureTableView()

        title = Constants.title

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
        tableView.isPagingEnabled = true
        tableView.register(BookCell.self, forCellReuseIdentifier: Constants.bookCell)
        tableView.fill(parent: view)
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getAuthors(_ index: Int) ->  String{
        var names = "By:"

        if bookResults.items[index].authors.count > 1 {
            bookResults.items[index].authors.forEach {author in
                names += " \(author.name),"
            }
            names = String(names.dropLast())

        } else {
            names += " \(bookResults.items[index].authors[0].name)"
        }

        return names
    }

    private func getNarrators(_ index: Int) -> String {
        if bookResults.items[index].narrators.count == 0 {

            return "With: TBA"
        }

        var names = "With:"

        if bookResults.items[index].narrators.count > 1 {
            bookResults.items[index].narrators.forEach {narrator in
                names += " \(narrator.name),"
            }
            names = String(names.dropLast())

        } else {
            names += " \(bookResults.items[index].narrators[0].name)"
        }

        return names
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookResults.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bookCell) as! BookCell

        cell.coverImage.load(urlString: bookResults.items[indexPath.row].cover.url)
        cell.titleLabel.text = bookResults.items[indexPath.row].title
        cell.authorLabel.text = getAuthors(indexPath.row)
        cell.narratorLabel.text = getNarrators(indexPath.row)

        return cell
    }
}
