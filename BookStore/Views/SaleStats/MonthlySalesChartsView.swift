//
//  MonthlySalesChartsView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI
import Charts
struct MonthlySalesChartsView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Month", sale.saleDate, unit: .month), y: .value("Sale", sale.quantity))
                
        }
    }
}

#Preview {
    MonthlySalesChartsView(salesData: Sale.threeMonthsExample())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
