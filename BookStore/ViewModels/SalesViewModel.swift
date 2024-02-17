//
//  SalesViewModel.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import Foundation

class SalesViewModel: ObservableObject {
    @Published var salesData = [Sale]()

    
    var totalSales: Int {
        salesData.reduce(0) {
            $0 + $1.quantity
        }
    }
    
    @Published var lastTotalSales:Int = 0
    
    var salesByWeek: [(day: Date, sales: Int)] {
        let salesByWeek = salesGroupedByWeek(sales: salesData)
        return totalSalesPerDate(salesByDate: salesByWeek)
    }
    
    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
        var salesByWeek: [Date: [Sale]] = [:]
        
        let calendar = Calendar.current
        for sale in sales {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents(
                [.yearForWeekOfYear, .weekOfYear], from: sale.saleDate)) else { continue }
            if salesByWeek[startOfWeek] != nil {
                salesByWeek[startOfWeek]!.append(sale)
            } else {
                salesByWeek[startOfWeek] = [sale]
            }
        }
        
        return salesByWeek;
    }
    
    func totalSalesPerDate(salesByDate: [Date: [Sale]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityByDate = sales.reduce(0) { $0 + $1.quantity}
            totalSales.append((day: date, sales: totalQuantityByDate))
        }
        
        return totalSales;
    }
    init() {
        //fetch from server
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.threeMonthsExample()
        vm.lastTotalSales = 1200
        return vm;
    }
}
