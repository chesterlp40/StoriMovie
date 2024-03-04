//
//  URLRequestBuilder.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import Foundation

/// Builder design pattern for construct **URLRequest** for **Movie** or **UIImaage**.
final class URLRequestBuilder {
    private let moviesBaseURL = "https://api.themoviedb.org/3/movie/top_rated"
    private let imagesBaseURL = "https://image.tmdb.org/t/p/original"
    private let pageKey = "page"
    private let token = "INSERT YOUR TOKEN HERE"

    private let timeOut = 10.0
    private var requestData: RequestData = .movieRequest
    private var imagePath: String = ""
    private var page: Int = 1
    
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
    
    /// Initialize **URLRequestBuilder**.
    ///
    /// - Parameter requestData: **RequestData**.
    init(
        _ requestData: RequestData
    ) {
        self.requestData = requestData
    }
    
    /// Set image path for **UIImage**.
    ///
    /// - Parameter imagePath: **String**.
    /// - Returns: **URLRequestBuilder**.
    @discardableResult
    func setImagePath(
        _ imagePath: String
    ) -> URLRequestBuilder {
        self.imagePath = imagePath
        return self
    }
    
    /// Set page for **Movie**.
    ///
    /// - Parameter page: **Int**.
    /// - Returns: **URLRequestBuilder**.
    @discardableResult
    func setPage(
        _ page: Int
    ) -> URLRequestBuilder {
        self.page = page
        return self
    }
    
    /// Build the **URLRequest**.
    ///
    /// - Returns: **URLRequest**.
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
