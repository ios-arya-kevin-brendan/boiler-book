
//
//  Class.swift
//  Boiler Book
//
//  Created by arya sharma on 4/11/21.
//

import Foundation

struct Class: Decodable {
  let name: String
  let category: Category
  
  enum Category: Decodable {
    case all
    case english //chocolate
    case math //hard
    case computer_science
  }
}

extension Class.Category: CaseIterable { }

extension Class.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "All": self = .all
    case "English": self = .english
    case "Math": self = .math
    case "CS": self = .computer_science
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .all: return "All"
    case .english: return "English"
    case .math: return "Math"
    case .computer_science: return "CS"
    }
  }
}

extension Class {
  static func classes() -> [Class] {
    guard
      let url = Bundle.main.url(forResource: "Classes", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
        print("hi there")
      return try decoder.decode([Class].self, from: data)
    } catch {
        print("HELLO")
      return []
        
    }
  }
}

