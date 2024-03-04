//
//  ImageViewModel.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 04/03/2024.
//

import UIKit

class ImageViewModel {
    
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
