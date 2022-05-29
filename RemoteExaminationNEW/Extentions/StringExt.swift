//
//  StringExt.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 23.05.2022.
//

import Foundation

extension String {
    var base64Encoded: String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
}
