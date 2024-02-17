//
//  WeeklySalesChartsView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI
import Charts
struct WeeklySalesChartsView: View {
    @ObservedObject var salesViewModel: SalesViewModel;
    @State private var rawSelectedDate: Date? = nil;
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
                
                return (startOfWeek...endOfWeek).contains(rawSelectedDate)
            }
        } else {
            return nil
        }
    }
    var body: some View {
        Chart {
            ForEach(salesViewModel.salesByWeek, id: \.day) { saleData in
                BarMark(x:
                        .value("Week", saleData.day, unit: .weekOfYear),
                        y:
                        .value("Sales", saleData.sales))
                .foregroundStyle(Color.blue.gradient)
                .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleData.day ? 1 : 0.5)
            }
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(
                        position: .top,
                        spacing: 0,
                        overflowResolution: .init(x: .fit(to: .chart), y: .disabled)
                    ) {
                        selectionPopover
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    var selectionPopover: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

#Preview {
    WeeklySalesChartsView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
