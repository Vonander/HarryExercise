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
    private lazy var nextPageToken = ""
    private lazy var bookItems = [Item]()
    private lazy var apiHandler = ApiHandler()
    private lazy var isFetchingMoreBooks = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.title

        configureTableView()
        fetchBooks(from: Constants.urlString)
    }

    private func fetchBooks(from urlString: String) {
        apiHandler.fetchBooksJSON(from: urlString) { (bookResults, error) in

            if let error = error  {
                print("Failed to fetch books: ", error)

                return
            }

            guard let bookResults = bookResults else { return }

            self.nextPageToken = bookResults.nextPageToken
            self.bookItems.append(contentsOf: bookResults.items)
            self.isFetchingMoreBooks = false

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
        tableView.register(LoadingCell.self, forCellReuseIdentifier: Constants.loadingCell)
        tableView.fill(parent: view)
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getAuthors(_ index: Int) ->  String{
        var names = "By:"

        if bookItems[index].authors.count > 1 {

            bookItems[index].authors.forEach {author in
                names += " \(author.name),"
            }
            names = String(names.dropLast())

        } else {
            names += " \(bookItems[index].authors[0].name)"
        }

        return names
    }

    private func getNarrators(_ index: Int) -> String {
        if bookItems[index].narrators.count == 0 {

            return "With: TBA"
        }

        var names = "With:"

        if bookItems[index].narrators.count > 1 {

            bookItems[index].narrators.forEach {narrator in
                names += " \(narrator.name),"
            }
            names = String(names.dropLast())

        } else {
            names += " \(bookItems[index].narrators[0].name)"
        }

        return names
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {

            if !isFetchingMoreBooks {
                beginBookFetch()
            }
        }
    }

    private func beginBookFetch() {
        isFetchingMoreBooks = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)

        fetchBooks(from: "\(Constants.urlString)&page=\(nextPageToken)")
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {

            return bookItems.count

        } else if section == 1 && isFetchingMoreBooks {

            return 1
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {

            let bookCell = tableView.dequeueReusableCell(withIdentifier: Constants.bookCell) as! BookCell

            bookCell.coverImage.load(urlString: bookItems[indexPath.row].cover.url)
            bookCell.titleLabel.text = bookItems[indexPath.row].title
            bookCell.authorLabel.text = getAuthors(indexPath.row)
            bookCell.narratorLabel.text = getNarrators(indexPath.row)

            return bookCell

        } else {

            let loadingCell = tableView.dequeueReusableCell(withIdentifier: Constants.loadingCell) as! LoadingCell
            loadingCell.activityIndicatior.startAnimating()

            return loadingCell
        }
    }
}
