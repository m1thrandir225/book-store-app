//
//  SalesByWeekdayView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI
import Charts

struct SalesByWeekdayView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var mediaSalesVisible = true
    @State private var individualSalesDaysVisible = false
    var body: some View {
        VStack(alignment: .leading) {
           SalesByWeekdayHeader(salesViewModel: salesViewModel)
            Chart {
                
                ForEach(salesViewModel.averageSalesByWeekday, id: \.number) {
                
                    BarMark(x: .value("Weekday", weekday(for:  $0.number)), y: .value("Average Sales", $0.sales), width: .ratio(0.7))
                        .foregroundStyle(Color.gray.gradient)
                        .opacity(0.3)
                    
                    RectangleMark(x: .value("Weekday", weekday(for:  $0.number)), y: .value("Average Sales", $0.sales), height: 3)
                        .foregroundStyle(Color.gray)
                    
                }
                if mediaSalesVisible {
                    RuleMark(y: .value("Median Sales", salesViewModel.medianSales))
                        .foregroundStyle(.indigo)
                        .annotation(position: .top, alignment: .trailing) {
                            Text ("Median: \(String(format: "%.2f", salesViewModel.medianSales))")
                                .font(.body.bold())
                                .foregroundStyle(.indigo)
                        }
                }
                
                if individualSalesDaysVisible {
                    ForEach(salesViewModel.salesByWeekDay, id: \.number) { weekdayData in
                        ForEach(weekdayData.sales) { sale in
                            PointMark(x:
                                    .value("day", weekday(for: weekdayData.number)),
                                      y: .value("sales", sale.quantity)
                                    
                            )
                            .opacity(0.3)
                        }
                    }
                }
                
              
            }
            .aspectRatio(1, contentMode: .fit)
            
            Toggle(individualSalesDaysVisible ? "Show all daily sales" : "Hide daily sales", isOn: $individualSalesDaysVisible.animation())
            Toggle(mediaSalesVisible ? "Show median sales" : "Hide median sales", isOn: $mediaSalesVisible.animation())
            
            Spacer()
        }.padding()
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[number - 1]
    }

}

#Preview {
    SalesByWeekdayView(salesViewModel: .preview)
}
