//
//  Profile.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct Profil: View {
    var body: some View {
        VStack {
            VStack {
                Rectangle().foregroundColor(Color(UIColor(named: "putih_bg")!))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 180)
                Image("profile").resizable().aspectRatio(contentMode: .fill)
                    .clipShape(Circle()).frame(width: 200, height: 200)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .offset(y: -120).padding(.bottom, -130)
                VStack {
                    Text("Kurniawan Gigih L.U")
                        .bold()
                        .font(.title)
                    Text("Umam.tekno@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
            }
            Spacer()
        }
        .navigationBarTitle(Text("Profil"))
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profil()
    }
}
