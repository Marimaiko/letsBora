//
//  String+Extension.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//
import Foundation
extension String {
    func toDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        if let date = dateFormatter.date(from:self){
            return date
        } else {
            print("Failed to convert \(self) to Date")
        }
        return nil
    }
}
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter.string(from: self)
    }
}
