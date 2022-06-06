//
//  MessageList.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import Foundation

// MARK: - MessageList

struct MessageList: Codable {
    let content: [Message]
    let pageable: Pageable
    let totalPages, totalElements: Int
    let last: Bool
    let number: Int
    let sort: Sort
    let size, numberOfElements: Int
    let first, empty: Bool
}

// MARK: - Message

struct Message: Codable {
    let id: Int
    let text: String
    let sendTime: Int
    let accountId: Int
    let artefactId: Int?
}

// MARK: - Pageable

struct Pageable: Codable {
    let sort: Sort
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
}

// MARK: - Sort

struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
