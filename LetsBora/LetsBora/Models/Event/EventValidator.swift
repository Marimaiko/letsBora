//
//  EventValidator.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//


import UIKit

struct EventValidationResult {
    var isValid: Bool
    var errors: [ValidationField: String]
}

enum ValidationField {
    case name
    case description
    case dateTime
    case location
    case category
}

struct EventValidator {
    
    static func validateInputs(
        name: String?,
        description: String?,
        dateTime: Date?,
        location: EventLocationDetails?,
        category: String?
    ) -> EventValidationResult {
        
        var errors: [ValidationField: String] = [:]
        
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmedName.isEmpty {
            errors[.name] = "Nome do evento é obrigatório."
        } else if trimmedName.count < 3 {
            errors[.name] = "Nome do evento deve ter pelo menos 3 caracteres."
        }
        
        let trimmedDescription = description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmedDescription.isEmpty {
            errors[.description] = "Descrição é obrigatória."
        } else if trimmedDescription.count < 10 {
            errors[.description] = "Descrição deve ter pelo menos 10 caracteres."
        }
        
        if dateTime == nil {
            errors[.dateTime] = "Data e hora são obrigatórias."
        } else if let selectedDate = dateTime, selectedDate <= Date() {
            errors[.dateTime] = "A data e hora do evento devem ser futuras."
        }
        
        if location == nil {
            errors[.location] = "Localização é obrigatória."
        }
        
        if category?.isEmpty ?? true {
            errors[.category] = "Categoria é obrigatória."
        }
        
        return EventValidationResult(isValid: errors.isEmpty, errors: errors)
    }
}
