//
//  CalendarView.swift
//  MyHodl
//
//  Created by DarkSatyr on 05.02.2026.
//

import SwiftUI

struct CalendarView: View {
    let title: String
    @Binding var selectedDate: Date
    let datesRange: PartialRangeThrough<Date>
    
    var body: some View {
        DatePicker(
            title,
            selection: $selectedDate,
            in: datesRange,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .padding()
    }
}

#Preview {
    CalendarView(title: "Select date",
                 selectedDate: Binding(get: {
        Date()
    }, set: { date in
        
    }), datesRange: ...Date())
}
