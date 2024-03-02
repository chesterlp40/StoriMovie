//
//  URLRequestBuilder.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import Foundation

class URLRequestBuilder {
    private let moviesBaseURL = "https://api.themoviedb.org/3/movie/top_rated"
    private let imagesBaseURL = "https://image.tmdb.org/t/p/original"
    private let pageKey = "page"
    private let token = "TOKEN"

    private let timeOut = 10.0
    private(set) var requestData: RequestData = .movieRequest
    private(set) var imagePath: String = ""
    private(set) var page: Int = 1
    
    enum RequestData: String {
        case movieRequest
        case imageRequest
    }
    
    private enum KeyHeader: String {
        case Authorization = "Authorization"
        case accept = "accept"
    }
    
    private enum RequestMethod: String {
        case get = "GET"
    }
    
    init(
        _ requestData: RequestData
    ) {
        self.requestData = requestData
    }
    
    @discardableResult
    func setImagePath(
        _ imagePath: String
    ) -> URLRequestBuilder {
        self.imagePath = imagePath
        return self
    }
    
    @discardableResult
    func setPage(
        _ page: Int
    ) -> URLRequestBuilder {
        self.page = page
        return self
    }
    
    func build() -> URLRequest? {
        var urlString: String?
        switch self.requestData {
        case .movieRequest:
            urlString = "\(self.moviesBaseURL)"
        case .imageRequest:
            urlString = "\(self.imagesBaseURL)\(self.imagePath)"
        }
        guard
            let safeUrlString = urlString,
            let safeUrl = URL(string: safeUrlString),
            var urlComponents = URLComponents(
                url: safeUrl,
                resolvingAgainstBaseURL: false
            )
        else {
            return nil
        }
        if self.requestData == .movieRequest {
            var queryItems = urlComponents.queryItems ?? []
            let pageItem = URLQueryItem(
                name: self.pageKey,
                value: self.page.description
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
            timeoutInterval: self.timeOut
        )
        request.httpMethod = RequestMethod.get.rawValue
        var headers = [KeyHeader: String]()
        headers[.Authorization] = "Bearer \(self.token)"
        headers[.accept] = "application/json"
        for header in headers {
            request.setValue(
                header.value,
                forHTTPHeaderField: header.key.rawValue
            )
        }
        return request
    }
}
