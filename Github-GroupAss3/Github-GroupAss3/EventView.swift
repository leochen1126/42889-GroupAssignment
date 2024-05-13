//
//  EventView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun on 13/5/2024.
//

import SwiftUI

struct EventView: View {
    let events: [Event] = [
        Event(id: 0, title: "Kingdom of the Planet of the Apes", description: "Join the current hype about the third movie in the franchise of the Planet of the Apes. Program also contains the display of life-life models and the merchandise sales.", imageUrl: URL(string: "https://variety.com/wp-content/uploads/2024/05/GF1_0890.jpg")!),
        Event(id: 1, title: "Dune: Part Two", description: "Get transported to another galaxy and witness an epic tale that spans several galactic civilizations. Members can enjoy the immersive experience programs.", imageUrl: URL(string: "https://midwesttheater.com/wp-content/uploads/2024/03/WEB-Dune-2.jpg")!)
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                padding()
                titleText
                eventsScrollView
            }
        }
    }

    private var titleText: some View {
        Text("Events")
            .font(.largeTitle)
            .foregroundColor(.white)
            .bold()
    }

    private var eventsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(events, id: \.id) { event in
                    eventCard(event: event)
                }
            }
            .padding(.horizontal)
        }
    }

    private func eventCard(event: Event) -> some View {
        VStack {
            AsyncImage(url: event.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 200, height: 200)
                         .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                @unknown default:
                    EmptyView()
                }
            }
            .overlay(
                Text("Event \(event.id + 1)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
                    .padding(10),
                alignment: .topLeading
            )

            Text(event.title)
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top, 5)

            Text(event.description)
                .foregroundColor(.white)
                .font(.body)
                .multilineTextAlignment(.center)
                .frame(width: 180)
                .padding(.top, 2)
        }
        .frame(width: 300, height: 500)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0, y: 2)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}

