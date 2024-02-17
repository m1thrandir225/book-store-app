//
//  DailySalesChartsView.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import SwiftUI
import Charts

struct DailySalesChartsView: View {
    init(salesData: [Sale]) {
        self.salesData = salesData
        guard let lastDate = salesData.last?.saleDate else { return }
        let begginingOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
        self._scrollPosition = State(initialValue: begginingOfInterval.timeIntervalSinceReferenceDate)
    }
    let salesData: [Sale]
    let numberOfDisplayDays = 30
    @State private var scrollPosition: TimeInterval = TimeInterval()
    
    var scrollPositionStart: Date {
        Date(timeIntervalSinceReferenceDate: scrollPosition)
    }
    
    var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    var scrollPositionStartString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
    var body: some View {
        VStack(alignment: .leading){
            Text("\(scrollPositionStartString) - \(scrollPositionEndString)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Chart(salesData) { sale in
                BarMark(x: .value("Day", sale.saleDate, unit: .day),
                        y: .value("Sales", sale.quantity))
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayDays)
            .chartScrollTargetBehavior(.valueAligned(matching: .init(hour: 0), majorAlignment: .matching(.init(day: 1))))
            .chartScrollPosition(x: $scrollPosition)
        }
    }
}

#Preview {
    DailySalesChartsView(salesData: Sale.threeMonthsExample())
        .aspectRatio(1, contentMode: .fit)
        .padding()
    
}
