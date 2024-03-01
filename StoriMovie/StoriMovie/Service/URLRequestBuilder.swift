//
//  URLRequestBuilder.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import Foundation

class URLRequestBuilder {
    private let baseURL = "https://api.themoviedb.org/3/movie"
    private let pageKey = "page"
    private let headers = [
      "accept": "application/json",
      "Authorization": "Bearer TOKEN"
    ]
    private(set) var path: String
    private(set) var page: Int? = nil
    
    init(
        path: String
    ) {
        self.path = path
    }
    
    @discardableResult
    func setPage(
        _ page: Int
    ) -> URLRequestBuilder {
        self.page = page
        return self
    }
    
    func build() -> URLRequest? {
        let fullUrl = self.baseURL + self.path
        guard
            let safeBaseUrl = URL(string: fullUrl),
            var urlComponents = URLComponents(
                url: safeBaseUrl,
                resolvingAgainstBaseURL: false
            )
        else {
            return nil
        }
        if let safePage = self.page?.description {
            var queryItems = urlComponents.queryItems ?? []
            let pageItem = URLQueryItem(
                name: self.pageKey,
                value: safePage
            )
            queryItems.append(pageItem)
            urlComponents.queryItems = queryItems
        }
        guard
            let safeUrl = urlComponents.url
        else {
            return nil
        }
        var request = URLRequest(
            url: safeUrl,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = self.headers
        return request
    }
}
