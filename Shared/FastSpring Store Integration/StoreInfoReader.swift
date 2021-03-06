// Copyright (c) 2015-2019 Christian Tietze
// 
// See the file LICENSE for copying permission.

import Foundation

public class StoreInfoReader {
    
    static func defaultStoreInfo() -> StoreInfo? {
        guard let url = Bundle.main.url(forResource: "FastSpringCredentials", withExtension: "plist") else {
            return nil
        }

        return storeInfo(fromURL: url)
    }
    
    public static func storeInfo(fromURL url: Foundation.URL) -> StoreInfo? {
        guard let info = NSDictionary(contentsOf: url) as? [String : String] else {
            return nil
        }
        return storeInfo(fromDictionary: info)
    }
    
    public static func storeInfo(fromDictionary info: [String : String]) -> StoreInfo? {
        guard let storeId = info["storeId"],
            let productName = info["productName"] ,
            let productId = info["productId"] else {
                
            return nil
        }
        
        #if DEBUG
            NSLog("Test Store Mode")
            let storeMode = kFsprgModeTest
        #else
            NSLog("Active Store Mode")
            let storeMode = kFsprgModeActive
        #endif
        
        return StoreInfo(
            storeId: storeId,
            productName: productName,
            productId: productId,
            storeMode: storeMode)
    }
}
