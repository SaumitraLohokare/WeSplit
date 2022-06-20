//
//  ContentView.swift
//  WeSplit
//
//  Created by Saumitra Lohokare on 6/19/22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var splitBetween = 2
    @State private var tipPercent = 20
    
    @FocusState private var isKeyboardOn: Bool
    
    var split: Double {
        let billWithTax: Double = billAmount + (billAmount * (Double(tipPercent)/100.0))
        return billWithTax / Double(splitBetween)
    }
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isKeyboardOn)
                    TextField("People", value: $splitBetween, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isKeyboardOn)
                }
                
                Section {
                    Picker("Tip", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Text(split, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isKeyboardOn = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
