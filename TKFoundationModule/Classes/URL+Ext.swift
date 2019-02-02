//
//  URL+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/3.
//

import Foundation

extension URL : NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == URL {

    var queryDictionary: [String: String]? {
        guard let query = self.wrappedValue.query else { return nil}
        
        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {
            
            let key = pair.components(separatedBy: "=")[0]
            
            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""
            
            queryStrings[key] = value
        }
        return queryStrings
    }
}
