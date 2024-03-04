//
//  ImageViewModel.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 04/03/2024.
//

import UIKit

/// View Model asociated to **UIImage** model.
class ImageViewModel {
    
    /// Request data.
    ///
    /// - Parameter path: **String**.
    /// - Returns: **UIImage**
    func fetchImage(
        with path: String
    ) async throws -> UIImage? {
        do {
            return try await RestClientService.shared.fetchImage(
                with: path
            )
        } catch {
            throw error
        }
    }
}
