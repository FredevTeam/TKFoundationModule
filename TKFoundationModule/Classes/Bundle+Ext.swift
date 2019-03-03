//
//  Bundle+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/17.
//

import Foundation

extension TypeWrapperProtocol where WrappedType == Bundle {
    
    /// 系统所有的framework
    ///
    /// - Returns: 元祖  (system, other)
    public static func frameworks() -> (system:[Bundle], other: [Bundle]) {
        var sysF = [Bundle]()
        var otherF = [Bundle]()
        Bundle.allFrameworks.forEach { (bundle) in
            if bundle.executablePath?.range(of: ".app/Framework") != nil {
                otherF.append(bundle)
            }else {
                sysF.append(bundle)
            }
        }
        return (system: sysF, other: otherF)
    }
}
