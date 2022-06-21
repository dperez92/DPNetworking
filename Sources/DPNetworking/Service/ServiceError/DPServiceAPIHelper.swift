//
//  DPServiceAPIHelper.swift
//  
//
//  Created by Daniel Perez Olivares on 18-05-22.
//

import Foundation

public enum ServiceError: Error {
    case invalidURL
    case emptyData
    case unhandledError
    case malformedResponse
    case serverError
    case resourceNotFound
    case unauthorized
}

func resolveHTTPError(statusCode: Int) -> ServiceError {
    switch statusCode {
    case 500:
        return .serverError
    case 404:
        return .resourceNotFound
    case 401:
        return .unauthorized
    default:
        return .unhandledError
    }
}
