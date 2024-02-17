//
//  ContentView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI

struct ContentView: View {
    @State var salesViewModel = SalesViewModel.preview
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        DetailBookSalesView(salesViewModel: salesViewModel)
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                Section {
                    NavigationLink {
                        SalesByWeekdayView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
                }
            }.navigationTitle("Your Book Store Stats")
        }
    }
}

#Preview {
    ContentView()
}
