//
//  HarryExerciseTests.swift
//  HarryExerciseTests
//
//  Created by Johan Fornander on 2020-05-17.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import XCTest
import Foundation
import UIKit

class HarryExerciseTests: XCTestCase {

    func testApiResponseAndFetchRequest() {

        let promise = expectation(description: "payload fetched")

        guard let url = URL(string: Constants.urlString) else {
            XCTFail()

            return
        }

        URLSession.shared.dataTask(with: url) { (data, respond, error) in
            XCTAssertNil(error)

            guard let data = data else {
                XCTFail()

                return
            }

            do {
                let result = try JSONDecoder().decode(ApiPayload.self, from: data)
                XCTAssertNotNil(result)
                promise.fulfill()

            } catch {
                XCTFail()
            }

        }.resume()

        wait(for: [promise], timeout: 5)
    }
}
