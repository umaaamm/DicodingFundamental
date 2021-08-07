//
//  ContentView.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var modelGames = ListViewModel()
    // MARK: - Init NavBar
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(named: "color_blue")
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .spacingLarge) {
                HomeSearchView(query: self.$modelGames.query)
                    .padding([.leading, .trailing, .top], .spacingLarge)
                LoadingView(isShowing: self.$modelGames.isAnimatingLoading) {
                    List {
                        if !self.modelGames.isAnimatingLoading {
                            if self.modelGames.dataGames.count > 0 {
                                ForEach(self.modelGames.dataGames) { item in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color("putih_bg"))
                                        LayoutList(item: item)
                                        NavigationLink(destination: DetailGames(itemDetail: item )) {
                                            EmptyView()
                                        }
                                    }
                                }
                            } else {
                                Text("Data Tidak ditemukan, silahkan cari dengan kata lain")
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing:
                                    VStack {
                                        NavigationLink(destination: Profil()) {
                                            Image(systemName: "person.crop.circle.fill").foregroundColor(.white)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    })
            .navigationBarTitle(Text("All Games"))
        }
        .accentColor( .white)
        .onAppear {
            self.modelGames.getGames()
        }
    }
}

struct HomeSearchView: View {
    @Binding var query: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("gray80"))
            TextField("Search Games", text: $query)
                .foregroundColor(Color("gray80"))
        }
        .padding(.spacingNormal)
        .background(Color("gray20"))
        .cornerRadius(.spacingSmall)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
