//
//  XAccessTokenService.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 03.06.2022.
//

import Foundation

final class XAccessTokenService {
    
    // MARK: Shared
    
    static let shared = XAccessTokenService()
    
    // MARK: Properties
    
    var token: String = ""
    
    // MARK: Init

    private init() { }
}
