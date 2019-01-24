//
//  AppInfo.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

// App Info

let infoDic = Bundle.main.infoDictionary


/// app version
let appVersion = (infoDic?["CFBundleShortVersionString"] as? String) ?? ""


/// App build version
let appBuildVersion = (infoDic?["CFBundleVersion"] as? String) ?? ""


/// App 名字
let appName = (infoDic?["CFBundleDisplayName"] as? String) ?? ""
