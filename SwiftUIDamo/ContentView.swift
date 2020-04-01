//
//  ContentView.swift
//  SwiftUIDamo
//
//  Created by ajay lather on 01/04/20.
//  Copyright © 2020 Ajay Lather. All rights reserved.
//
import Combine
import SwiftUI

class DataSource: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()
    init() {
        let fm = FileManager.default
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("IMG") {
                    pictures.append(item)
                }
            }
        }
        didChange.send(())
    }
    
}
struct DetailView: View {
    var selectedImage: String
    var body: some View {
        let image = UIImage(named: selectedImage)!
        return Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .navigationBarTitle(Text(selectedImage))
    }
}
struct ContentView: View {
    @ObservedObject var dataSource = DataSource()
    var body: some View {
        NavigationView {
            List(dataSource.pictures, id:\.self) { picture in
                NavigationLink(destination: DetailView(selectedImage: picture)) {
                   Text(picture)
                }
            }.navigationBarTitle("Desa Green Apartment")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
