//
//  ContentView.swift
//  Prorater
//
//  Created by Fernando de Orbegoso on 8/4/20.
//  Copyright © 2020 Fernando de Orbegoso. All rights reserved.
//  v2.0 on 2/15/2023

import SwiftUI
import SwiftUIKit

struct ContentView: View {
    
    @State private var rentAmount: Double? = 0.0
    @State private var startDate = Date()
    
    var totalDaysInMonth : Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: startDate)
        return range!.count
    }
    
    var remainingDaysInMonth : Int {
        let calendar = Calendar.current
        let selectedDate = calendar.component(.day, from: startDate)
        let remainingDays = (totalDaysInMonth - Int(selectedDate)) + 1
        return remainingDays
        
    }
    
    var amount: Double {
        let rentDouble = rentAmount!
        return rentDouble
    }
    
    var proratedRent : Double {
        let rentDouble = rentAmount!
        let dailyRent = rentDouble / Double(totalDaysInMonth)
        return dailyRent * Double(remainingDaysInMonth)
    }
    
    var dailyRent : Double {
        let rentDouble = rentAmount!
        let rate = rentDouble / Double(totalDaysInMonth)
        return rate
    }
   

    var body: some View {
        NavigationView {
            Form {
                Section {
                    CurrencyTextField("Enter Amount",  value : $rentAmount)
                        .keyboardType(.decimalPad)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        } header:  {
                            Text("Enter amount")
                        }

                                
                Section {
                    DatePicker("Select Date", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(.blue)
                    Text("Days remaining: \(remainingDaysInMonth) ")
                    
                } header: {
                    Text("Select date")
                }
                
                              
                Section {
                    if rentAmount != nil {
                        Text("Prorated amount: $\(proratedRent, specifier: "%.2f")")
                        Text("Daliy rate: $\(dailyRent, specifier: "%.2f")")
                    }
                    
                } header: {
                    Text("Results")
                }
            }
            
            .navigationTitle("Prorater")
//            .font(.subheadline)

        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(.device)
        }
    }
}


