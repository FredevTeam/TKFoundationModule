//
//  Bundle+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/17.
//

import Foundation

extension TypeWrapperProtocol where WrappedType == Bundle {
    
    /// 分类所有 framework
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
    
    
    /// bundle url
    ///
    /// - Parameter bundleClass: any class form bundle
    /// - Returns: url
    public static func bundleName(from bundleClass: AnyClass) -> URL? {
        let bundle = Bundle.init(for: bundleClass)
        guard let bundleName = bundle.infoDictionary?[kCFBundleNameKey as String] as? String,
            let url = bundle.url(forResource: bundleName, withExtension: "bundle")
            else { return nil }
        return url
    }
    
    /// 根据指定类获取 bundle
    ///
    /// - Parameter bundleClass: 类
    /// - Returns: bundle
    public static func bundleResure(of bundleClass: AnyClass) -> Bundle? {
        let bundle = Bundle(for: bundleClass)
        guard let bundleName = bundle.infoDictionary?[kCFBundleNameKey as String] as? String,
            let url = bundle.url(forResource: bundleName, withExtension: "bundle"),
            let resourceBundle = Bundle(url: url)
            else { return nil }
        return resourceBundle
    }
    
}
