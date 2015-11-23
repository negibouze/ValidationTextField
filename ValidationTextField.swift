//
//  ValidationTextField.swift
//  ValidationTextField
//
//  Created by Yoshiaki Itakura on 2015/11/06.
//  Copyright © 2015年 personal. All rights reserved.
//

import UIKit

class ValidationTextField: UITextField {

    enum Rules {
        case Require
        case MinLength
        case MaxLength
        case Range
        case Numeric
        case Alpha
        case Alphanumeric
        case Email
    }
    @IBInspectable var minLength: Int = 0
    @IBInspectable var maxLength: Int = 0

    private var value: String = "";

    func validate(rules: [Rules], success: (() -> Void)? = nil, error: ((msg: String) -> Void)? = nil) -> Void {
        releaseDecoration()
        value = (self.text ?? "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        for rule in rules {
            let result = validationHandler(rule)
            if (result.error) {
                self.errorDecoration()
                self.becomeFirstResponder()
                error?(msg: result.reason)
                return
            }
        }
        success?()
    }

    private func validationHandler(rule: Rules) -> (error: Bool, reason: String) {
        var result: (error: Bool, reason: String) = (false, "")
        switch rule {
        case Rules.Require:
            result = isBlank()
        case Rules.MinLength:
            result = isTooShort()
        case Rules.MaxLength:
            result = isTooLong()
        case Rules.Range:
            result = isOutOfRange()
        case Rules.Numeric:
            result = isNumeric()
        case Rules.Alpha:
            result = isAlpha()
        case Rules.Alphanumeric:
            result = isAlphanumeric()
        case Rules.Email:
            result = isEmail()
        }
        return result
    }

    // MARK: - Validations

    private func isBlank() -> (error: Bool, reason: String) {
        if (value.isEmpty) {
            return (true, "Not input")
        }
        return (false, "")
    }

    private func isTooShort() -> (error: Bool, reason: String) {
        if (value.characters.count < minLength) {
            return (true, "\(minLength) characters minimum")
        }
        return (false, "")
    }

    private func isTooLong() -> (error: Bool, reason: String) {
        if (maxLength < value.characters.count) {
            return (true, "\(maxLength) characters or less")
        }
        return (false, "")
    }

    private func isOutOfRange() -> (error: Bool, reason: String) {
        if (minLength ... maxLength ~= value.characters.count) {
            return (false, "")
        }
        return (true, "\(minLength) characters to \(maxLength) characters or less")
    }

    private func isNumeric() -> (error: Bool, reason: String) {
        if (patternMatch("^\\d+$")) {
            return (false, "")
        }
        return (true, "Only numbers")
    }

    private func isAlpha() -> (error: Bool, reason: String) {
        if (patternMatch("^[a-zA-Z]+$")) {
            return (false, "")
        }
        return (true, "Alphabetic only")
    }

    private func isAlphanumeric() -> (error: Bool, reason: String) {
        if (patternMatch("^[\\da-zA-Z]+$")) {
            return (false, "")
        }
        return (true, "Only alphanumeric characters")
    }

    private func isEmail() -> (error: Bool, reason: String) {
        if (patternMatch("^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
            return (false, "")
        }
        return (true, "Bad Email Address")
    }

    private func patternMatch(pattern: String) -> Bool {
        let regexp: NSRegularExpression = try! NSRegularExpression.init(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        return regexp.firstMatchInString(value, options: [], range: NSMakeRange(0, value.characters.count)) != nil
    }

    // MARK: - Error Field Decoration

    private func errorDecoration() {
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.rgb(207, green: 66, blue: 66).CGColor
        self.backgroundColor = UIColor.rgb(253, green: 249, blue: 249)
    }

    private func releaseDecoration() {
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.defaultBorderColor().CGColor
        self.backgroundColor = UIColor.clearColor()
    }
}
