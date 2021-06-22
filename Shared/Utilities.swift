//
//  Extensions.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI

var moneyGreen = Color(red: 50/255, green: 200/255, blue: 170/255)

func getAmount(amount: String) -> Float {
    var amountToReturn = amount
    amountToReturn.remove(at: amount.startIndex)
    return (amountToReturn as NSString).floatValue
}
