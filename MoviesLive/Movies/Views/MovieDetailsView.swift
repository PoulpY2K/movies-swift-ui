//
//  MovieDetailsView.swift
//  MoviesLive
//
//  Created by Digital on 29/03/2022.
//

import SwiftUI

struct MoviesView: View {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let movie: Movie = Movie(titre: "Shrek", sous_titre: "Shrek: Les origines", date_sortie: "4 Jul 2001", duree_film: TimeInterval(5_400), categories: ["Fantastique", "Action", "Aventure"], synopsis: "Il était une fois, dans un marais lointain, un ogre au nom de Shrek qui voit sa précieuse solitude brisée pas une invasion de personnages de contes de fées agaçants. Ils ont tous été bannis de leur royaume par le méchant Lord Farquaad.", affiche: "shrek_affiche", poster: "shrek_poster", trailer_lien: URL(string: "https://www.youtube.com/watch?v=CwXOrWvPBPk")!)
    
    func getTodayDateLocale() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        let englishDate: Date = dateFormatter.date(from: movie.date_sortie)!
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = Locale(identifier: "FR-fr")
        return dateFormatter.string(from: englishDate)
    }
    
    func getTimeFormatted() -> String {
        let timeFormatter: DateComponentsFormatter = DateComponentsFormatter()
        timeFormatter.unitsStyle = .abbreviated
        timeFormatter.zeroFormattingBehavior = .dropAll
        timeFormatter.allowedUnits = [.hour, .minute]
        return timeFormatter.string(from: movie.duree_film)!
    }
    
    var body: some View {
        VStack(content: {
            ZStack(alignment: .top, content: {
                VStack(content: {
                    Image(movie.poster).resizable().aspectRatio(contentMode: .fill).frame(width: screenSize.width, height: screenSize.height/3).ignoresSafeArea().cornerRadius(15)
                })
                VStack(content: {
                    Image(movie.affiche).resizable().aspectRatio(contentMode: .fill).frame(width: screenSize.width/3, height: screenSize.height/4).cornerRadius(10)
                }).frame(minWidth:0, maxWidth: screenSize.width, minHeight: 0, maxHeight: screenSize.height/2.2, alignment: .bottom)
            })
            
            VStack(spacing: screenSize.width/25, content: {
                VStack(spacing: screenSize.width/90, content: {
                    Text(movie.titre)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text(movie.sous_titre)
                        .font(.callout)
                        .fontWeight(.regular)
                })
                
                HStack(alignment: .center, spacing: screenSize.width/15, content: {
                    ForEach(0...2, id: \.self) {
                        Text(movie.categories[$0])
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 10,
                                    bottom: 5,
                                    trailing: 10) )
                            .background(
                                Color("dark_green")
                            )
                            .cornerRadius(60)
                    }
                })
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: screenSize.width/20, content: {
                    Text(getTodayDateLocale())
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Text("-")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Text(getTimeFormatted())
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                })
            }).frame(
                minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                alignment: .top)
            
            VStack(content: {
                Divider()
            }).frame(width: screenSize.width/1.1, height: screenSize.height/50, alignment:.center)
            
            VStack(alignment: .leading, spacing: screenSize.height/40, content: {
                Text("Synopsis")
                    .font(.title3)
                    .fontWeight(.medium)
                ScrollView(content: {
                    Text(movie.synopsis)
                        .font(.body)
                        .fontWeight(.regular)
                        .lineLimit(nil)
                })
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: screenSize.width/1.1, maxHeight: screenSize.height/5.8, alignment: .topLeading)
            
            VStack(content: {
                Divider()
            }).frame(width: screenSize.width/1.1, height: screenSize.height/40, alignment:.center)
            
            VStack(alignment: .trailing, content: {
                Button(action: {  UIApplication.shared.open(movie.trailer_lien, options: [:], completionHandler: nil)}, label: {
                    Image(systemName: "play.circle").resizable().aspectRatio(contentMode: .fit).frame(width: screenSize.width/7)
                })
            }).frame(width: screenSize.width, height: screenSize.height/13, alignment: .bottom)
            
            
        })
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top)
        .ignoresSafeArea()
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
