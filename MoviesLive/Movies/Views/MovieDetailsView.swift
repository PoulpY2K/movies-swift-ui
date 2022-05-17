//
//  MovieDetailsView.swift
//  MoviesLive
//
//  Created by Digital on 29/03/2022.
//

import SwiftUI

struct MoviesDetailsView: View {
    let movie: MovieDetails
    let video_key: String
    
    init(movie: MovieDetails, video_key: String?) {
        self.movie = movie
        
        /// On vérifie que la clef du lien YouTube est bien présente, sinon vide
        if let finalVideoKey = video_key {
            self.video_key = finalVideoKey
        } else {
            self.video_key = ""
        }
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    /// Fonction permettant de formater la date
    func getTodayDateLocale() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        /// On vérifie que la date est bien valide, sinon on remplace par aucune
        if let englishDate: Date = dateFormatter.date(from: movie.release_date) {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale    = Locale(identifier: "FR-fr")
            return dateFormatter.string(from: englishDate)
        } else {
            return "Aucune date enregistrée"
        }
    }
    
    /// Fonction permettant de transformer le temps en minutes en heures + minutes
    func getTimeFormatted(time: Int) -> String {
        let hours = time / 60 % 60
        let minutes = time % 60
        
        return "\(hours)h\(minutes)m"
    }
    
    var body: some View {
        VStack(content: {
            /// ZStack contenant l'affiche et le poster
            ZStack(alignment: .top, content: {
                VStack(content: {
                    /// Pendant que l'image charge, on remplace par un spinner et un fond gris
                    AsyncImage(url: URL(string: K.TMDBImageURL + movie.backdrop_path)) {
                        image in image.resizable().aspectRatio(contentMode: .fill).frame(width: screenSize.width, height: screenSize.height/3).ignoresSafeArea().cornerRadius(15)
                    } placeholder: {
                        ProgressView().tint(.white).scaleEffect(1.5, anchor: .center).frame(width: screenSize.width, height: screenSize.height/3).ignoresSafeArea().background(.gray)
                    }
                    
                })
                
                VStack(content: {
                    /// Pendant que l'image charge, on remplace par un spinner et un fond gris
                    AsyncImage(url: URL(string: K.TMDBImageURL + movie.poster_path)){
                        image in
                        image.resizable().aspectRatio(contentMode: .fit).frame(width: screenSize.width/3, height: screenSize.height/4).cornerRadius(10)
                    } placeholder: {
                        ProgressView().tint(.black).scaleEffect(1.5, anchor: .center).frame(width: screenSize.width/3, height: screenSize.height/4).cornerRadius(10).ignoresSafeArea().background(Color("light_gray"))
                    }
                }).frame(minWidth:0, maxWidth: screenSize.width, minHeight: 0, maxHeight: screenSize.height/2.2, alignment: .bottom)
            })
            
            VStack(spacing: screenSize.width/25, content: {
                
                /// VStack du titre du film
                VStack(spacing: screenSize.width/90, content: {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text(movie.original_title)
                        .font(.callout)
                        .fontWeight(.regular)
                })
                
                /// HStack et son ForEach permettant d'afficher trois catégories dans des pills
                /// On vérifie que le nombre de catégories  n'est pas inférieur à 3 pour éviter de tomber
                /// en dehors de l'index du tableau
                HStack(alignment: .center, spacing: screenSize.width/15, content: {
                    let nbOfGenre: Int = movie.genres.count >= 3 ? 3 : movie.genres.count
                    
                    ForEach(0...nbOfGenre-1, id: \.self) {
                        Text(movie.genres[$0].name)
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
                                Color(
                                    red: .random(in: 0...0.5),
                                    green: .random(in: 0...0.5),
                                    blue: .random(in: 0...0.5)
                                )
                            )
                            .cornerRadius(60)
                        
                    }
                })
                
                /// HStack qui affiche la date de sortie et la durée du film
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: screenSize.width/20, content: {
                    Text(getTodayDateLocale())
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Text("-")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Text(getTimeFormatted(time: movie.runtime))
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
            
            /// VStack et ScrollView du résumé du film
            VStack(alignment: .leading, spacing: screenSize.height/40, content: {
                Text("Synopsis")
                    .font(.title3)
                    .fontWeight(.medium)
                ScrollView(content: {
                    Text(movie.overview)
                        .font(.body)
                        .fontWeight(.regular)
                        .lineLimit(nil)
                })
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: screenSize.width/1.1, maxHeight: screenSize.height/5.8, alignment: .topLeading)
            
            VStack(content: {
                Divider()
            }).frame(width: screenSize.width/1.1, height: screenSize.height/40, alignment:.center)
            
            /// VStack contenant le bouton et le lien de la vidéo YouTube
            VStack(alignment: .trailing, content: {
                /// On vérifie que la clef de la vidéo est bien présente
                if (video_key != "")
                {
                    /// On vérifie que la création de l'URL est correcte
                    if let videoUrl = URL(string: K.youtubeURL + video_key) {
                        Button(action: {  UIApplication.shared.open(videoUrl, options: [:], completionHandler: nil)}, label: {
                            Image(systemName: "play.circle").resizable().aspectRatio(contentMode: .fit).frame(width: screenSize.width/7)})
                    } else {
                        Text("Une erreur est survenue")
                    }
                } else {Text("Aucun vidéo disponible")}
            }).frame(width: screenSize.width, height: screenSize.height/10, alignment: .top)
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
        MoviesDetailsView(movie: MovieDetails(id: 0, title: "Inexistant", original_title: "Inexistant", overview: "Pas disponible", genres: [Genre(id: -1, name: "null")], backdrop_path: "null", poster_path: "null", release_date: "null", runtime: 0, video: false), video_key: "")
    }
}
