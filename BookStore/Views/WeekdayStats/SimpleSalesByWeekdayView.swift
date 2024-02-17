//
//  SimpleSalesByWeekdayView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI
import Charts


struct SimpleSalesByWeekdayView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    var body: some View {
        VStack(alignment: .leading) {
           SalesByWeekdayHeader(salesViewModel: salesViewModel)
            Chart(salesViewModel.averageSalesByWeekday, id: \.number) {
                
                BarMark(x: .value("Weekday", weekday(for:  $0.number)), y: .value("Average Sales", $0.sales), width: .ratio(0.7))
                    .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.5)
                    .foregroundStyle(Color.accentColor.gradient)
            }
            .frame(height: 70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }.padding()
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1]
    }

}

#Preview {
    SimpleSalesByWeekdayView(salesViewModel: .preview)
}
