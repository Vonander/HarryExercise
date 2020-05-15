//
//  ApiHandler.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-15.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import Foundation
import UIKit

class ApiHandler: NSObject {

    func fetchBooksJSON(completion: @escaping (ApiPayload?, Error?) -> ()) {

        guard let url = URL(string: Constants.urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, respond, error) in

            if let error = error {
                completion(nil, error)

                return
            }

            guard let data = data else { return }

            do {
                let bookResults = try JSONDecoder().decode(ApiPayload.self, from: data)
                completion(bookResults, nil)

            } catch let jsonError {
                print("Error serialization json", jsonError)
            }

        }.resume()
    }
}
