//: Playground - noun: a place where people can play

import Cocoa

enum SyntaxError: ErrorType {
    case MissingEndingCharacter(rawString: String)
    case MissingLastEndingCharacter(rawString: String)
}

func capitalize(rawString: String) ->String {
    // check syntax
    if let error = isCorrectSyntax(rawString) {
        switch error {
        case .MissingEndingCharacter(let incorrectString):
            print("Error: There is no ending character in \(incorrectString)")
        case .MissingLastEndingCharacter:
            print("Error: Missing last ending character [! or .]")
        }
        return rawString
    }
    
    // cat
    var message = rawString.lowercaseString
    let re = "[!.]"
    var range = message.rangeOfString(re, options: .RegularExpressionSearch)
    var sentences = [String]()
    while(range != nil && !range!.isEmpty) {
        var sentence = message.substringToIndex(range!.maxElement()!.advancedBy(1))
        let firstCharacterRange = sentence.rangeOfString("\\S", options: .RegularExpressionSearch)
        if let first = firstCharacterRange {
            sentence = sentence.stringByReplacingCharactersInRange(first, withString: String(sentence[first.startIndex]).uppercaseString)
        }
        sentences.append(sentence)
        message = message.substringFromIndex(range!.maxElement()!.advancedBy(1))
        range = message.rangeOfString(re, options: .RegularExpressionSearch)
    }
    return sentences.joinWithSeparator("")
}

func isCorrectSyntax(rawString: String) ->SyntaxError? {
    var error: SyntaxError? = nil
    let re = "[!.]"
    let trimmingContent = rawString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    
    // must has a character in [! or .]
    let firstRange = trimmingContent.rangeOfString(re, options: .RegularExpressionSearch)
    if firstRange == nil {
        error = .MissingEndingCharacter(rawString: rawString)
        return error
    }
    
    // last character is [! or .]
    let lastCharacter = trimmingContent.substringFromIndex(trimmingContent.endIndex.advancedBy(-1))
    let endingCharacterRange = lastCharacter.rangeOfString(re, options: .RegularExpressionSearch)
    if endingCharacterRange == nil {
        error = .MissingLastEndingCharacter(rawString: rawString)
    }
    return error
}

// MARK: - test

capitalize("heLlo WorLd! GooDBye worlD. nice tO Meet you!!!! jack, li")
capitalize("sss")

capitalize("heLlo WorLd! GooDBye worlD. nice tO Meet you!!!!")

