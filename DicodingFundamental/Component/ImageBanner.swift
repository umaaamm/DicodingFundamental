//
//  ImageBanner.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct ImageBanner: View {
    @ObservedObject var getImage: GetImage
    @State var image: UIImage = UIImage()

    init(withURL url: String) {
        getImage = GetImage(urlString: url)
    }

    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            Image(uiImage: image)
                .resizable()
                .aspectRatio(16/9, contentMode: .fit)
                .onReceive(getImage.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage(named: "placeImages")!
        }
        }
    }
}

struct ImageBanner_Previews: PreviewProvider {
    static var previews: some View {
        ImageBanner(withURL: "Dummy Url")
    }
}
