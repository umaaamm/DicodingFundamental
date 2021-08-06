//
//  ImageList.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import SwiftUI

struct ImageList: View {
    @ObservedObject var getImage: GetImage
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        getImage = GetImage(urlString:url)
    }
    var body: some View {
        VStack(alignment: .leading){
            Image(uiImage: image)
                .resizable().frame(width: 80, height: 80)
                .cornerRadius(10).shadow(radius: 5)
                .onReceive(getImage.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage(named: "placeImage")!
            }
        }
    }
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        ImageList(withURL: "Dummy Url")
    }
}
