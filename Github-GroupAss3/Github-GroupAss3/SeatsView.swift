//
//  SeatsView.swift
//  Github-GroupAss3
//
//  Created by Anna Huang on 12/5/2024.
//

import SwiftUI

struct SeatsView: View {
    @ObservedObject var viewModel: SeatsViewModel

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("🎬 Screen")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                Spacer()
                    .frame(height: 30)
                
                ForEach(["A", "B", "C", "D", "E"], id: \.self) { rowString in
                    let rowChar = rowString.first!
                    HStack(spacing: 10) {
                        ForEach(1...10, id: \.self) { number in
                            Button(action: {
                                let seat = Seat(row: rowChar, number: number, isOccupied: false, isSelected: false)
                                viewModel.selectSeat(seat)
                            }) {
                                Text("\(rowString)\(number)")
                                    .frame(width: 30, height: 30)
                                    .background(colorForSeat(row: rowChar, number: number))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                Text("Maximum 6 seats per booking")
                    .padding()
                    .foregroundColor(viewModel.selectedSeatsCount > 6 ? .red : .white)
                    .animation(.easeInOut, value: viewModel.selectedSeatsCount)
                
            }
        }
        .foregroundColor(.white)
    }

    
    private func colorForSeat(row: Character, number: Int) -> Color {
        if let seat = viewModel.seats.first(where: { $0.row == row && $0.number == number }) {
            if seat.isOccupied {
                return .gray
            } else if seat.isSelected {
                return .blue
            }
            return .green
        }
        return .green
    }
}

struct SeatsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SeatsViewModel()
        return SeatsView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
