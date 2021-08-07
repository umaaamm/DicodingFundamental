//
//  LayoutList.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct LayoutList: View {
    let item: Result
    var body: some View {
        HStack {
            ImageList(withURL: item.background_image ?? "")
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name).font(.headline).bold()
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.subheadline)
                    Text(String(item.rating)).font(.subheadline).foregroundColor(Color.gray)
                    Image(systemName: "play.circle.fill").foregroundColor(.yellow).font(.subheadline)
                    Text("\(String(item.playtime ?? 0)) hours").foregroundColor(Color.gray).font(.subheadline)
                    Spacer(minLength: 5)
                }
                Text("Game Release : \(formattedDateFromString(dateString: item.released) ?? "")").font(.footnote)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct LayoutList_Previews: PreviewProvider {
    static var previews: some View {
        LayoutList(item: Result(id: 1, slug: "Dummy Slug", name: "Dummy Nama", released: "2021-08-6", background_image: "Dummy Gambar", rating: 4.8, playtime: 40))
    }
}
