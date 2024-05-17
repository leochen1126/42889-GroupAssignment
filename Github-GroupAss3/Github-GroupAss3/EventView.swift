//
//  EventView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun on 12/5/2024.
//
import SwiftUI

struct EventView: View {
    let events: [Event] = [
        Event(id: 0, title: "Firsttimer Specials", description: "If you are arriving to the event first, you'll be considered for valuable perks.", imageName: "event_firsttime"),
        Event(id: 1, title: "Lucky Draw", description: "The lucky draws may contain tickets to other movies and promotional items.", imageName: "event_luck"),
        Event(id: 2, title: "Come in with Buddies", description: "The more the merrier. Join us in groups and be considered for a better seating", imageName: "event_buddy")
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
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
            .padding(.top, 50)
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
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .cornerRadius(10)
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
