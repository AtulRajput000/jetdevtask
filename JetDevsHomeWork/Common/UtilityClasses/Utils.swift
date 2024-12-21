//
//  Utils.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation
import UIKit

final class Utils {
    
    static func hx_color(withHexRGBAString: String) -> UIColor {
        var cString: String = withHexRGBAString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func jsonfromData(objectData: Data?) -> [String: Any]? {
        var json: [String: Any]?
        if objectData != nil {
            do {
                if let objectData = objectData {
                    json = try JSONSerialization.jsonObject(
                        with: objectData,
                        options: .mutableContainers) as? [String: Any]
                }
            } catch {
                return nil
            }
            return json
        }
        return nil
    }
    
    static func getContentFromUserDefault(_ key: String?) -> Any? {
        if let lKey = key, !lKey.isEmpty,
           let lContent = UserDefaults.standard.value(forKey: lKey) {
            return lContent
        }
        return nil
    }
   
    static func saveContentInUserDefault(_ content: Any?, key: String?) {
        if let lKey = key, !lKey.isEmpty,
           let lContent = content {
            UserDefaults.standard.set(lContent, forKey: lKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getAppDocumentDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsFolder = paths.count > 0 ? paths[0] : ""
        return documentsFolder
    }
}
