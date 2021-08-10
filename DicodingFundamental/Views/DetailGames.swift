//
//  DetailGames.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct DetailGames: View {
    let itemDetail: Result
    @ObservedObject var detailGames = DetailGamesViewModel()
    var body: some View {
        LoadingView(isShowing: self.$detailGames.isAnimatingLoading) {
            List {
                ImageBanner(withURL: self.itemDetail.background_image ?? "").listRowInsets(EdgeInsets(top: 0, leading: 0,
                                                                                                      bottom: 0, trailing: 0)).padding(.bottom)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(self.itemDetail.name).font(.headline)
                        Image(systemName: "play.circle.fill").foregroundColor(.yellow).font(.subheadline).padding(.leading)
                        Text("\(String(self.itemDetail.playtime ?? 0)) hours").foregroundColor(Color.gray).font(.subheadline)
                    }
                    HStack {
                        ForEach(0..<Int(self.itemDetail.rating)) { _ in
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.subheadline)
                        }
                        if self.itemDetail.rating >= 4.5 { Image(systemName: "star.lefthalf.fill").foregroundColor(.yellow).font(.subheadline) }
                        Text(String(self.itemDetail.rating)).font(.subheadline).foregroundColor(Color.gray)
                        Spacer(minLength: 5)
                    }
                    Text(self.detailGames.dataDetailGames?.description?.replacingOccurrences(of: "<[^>]+>", with: "",
                                                                                             options: String.CompareOptions.regularExpression, range: nil) ?? "-").font(.subheadline)
                }
            }
            .navigationBarTitle(Text("Detail Games"))
            .onAppear {
                self.detailGames.getDetailGames(id: self.itemDetail.id)
                if #available(iOS 14.0, *) {
                } else {
                    UITableView.appearance().tableFooterView = UIView()
                }
                UITableView.appearance().separatorStyle = .none
            }
        }.alert(isPresented: $detailGames.isAlert) {
            Alert(title: Text("Error"), message: Text("Terjadi Kesalahan Pada Saat Mengambil Data"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct DetailGames_Previews: PreviewProvider {
    static var previews: some View {
        DetailGames(itemDetail: Result(id: 1, slug: "Dummy Slug", name: "Dummy Nama", released: "2021-08-6", background_image: "Dummy Gambar", rating: 4.5, playtime: 30))
    }
}
