//
//  Home.swift
//  PhotoGalleryAndImageDownload
//
//  Created by Yaşar Duman on 1.10.2023.
//

import SwiftUI

struct Home: View {
    @State var sekmeler = ["Doğa","Hayvanlar","Balıklar","Çiçekler"]
    @State var arananIfade = ""
    @State var secilenSekme = "Doğa"
    
    @State var secilenGoruntuler : [[String]] = [["d11","d12"],["d21","d22"],["d31","d32"]]
    
    @State var dogaGoruntuleri : [[String]] = [["d11","d12"],["d21","d22"],["d31","d32"]]
    @State var balikGoruntuleri : [[String]] = [["b11","b12"],["b21","b22"],["b31","b32"]]
    @State var cicekGoruntuleri : [[String]] = [["c11","c12"],["c21","c22"],["c31","c32"]]
    @State var hayvanGoruntuleri : [[String]] = [["h11","h12"],["h21","h22"],["h31","h32"]]
    var body: some View {
        VStack{
            HStack{
                Button(action: {}, label: {
                    Image("menu").renderingMode(.original)
                })
                Spacer()
            }.padding()
                .background(Color.white).overlay(Image("logo").resizable().renderingMode(.original).frame(width: 120, height: 120))
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    // MARK: - Arama
                    HStack{
                        Image("ara").renderingMode(.original)
                        TextField("Ara", text: self.$arananIfade)
                    }.padding(12).background(Color("Renk1")).clipShape(Capsule())
                    // MARK: - Ana Image Menu
                    ZStack(alignment: .bottomTrailing){
                        Image("anaGoruntu").resizable().frame(height: 350)
                        HStack(spacing: 15){
                            Button(action: {}, label: { Image("ekle").renderingMode(.original) })
                            Button(action: {}, label: { Image("begeni").renderingMode(.original) })
                            Button(action: {}, label: { Image("indir").renderingMode(.original) })
                        }.padding()
                    }
                    // MARK: - Trend Olanlar Sekmleri
                    Text("Trend Olanlar ").font(.title).padding(.top)
                    HStack(spacing: 15){
                        ForEach(sekmeler, id: \.self){ s in
                            Button(action: {
                                self.secilenSekme = s
                                
                                switch s {
                                case "Doğa" : self.secilenGoruntuler = self.dogaGoruntuleri
                                case "Hayvanlar" : self.secilenGoruntuler = self.hayvanGoruntuleri
                                case "Çiçekler" : self.secilenGoruntuler = self.cicekGoruntuleri
                                case "Balıklar" : self.secilenGoruntuler = self.balikGoruntuleri
                                default :  self.secilenGoruntuler = self.dogaGoruntuleri
                                }
                            }, label: {
                                VStack{
                                    Text(s).foregroundStyle(.black)
                                    Capsule().fill(self.secilenSekme == s ? Color.black : Color.clear).frame(height: 6)
                                }
                            })
                        }
                    }.padding(.top)
                    // MARK: - Sekmeler
                    VStack(spacing: 18){
                        ForEach(secilenGoruntuler, id: \.self){ s in
                            HStack{
                                ForEach(s, id:\.self){ resimAdi in
                                    Image(resimAdi)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 180)
                                        .cornerRadius(15)
                                        .contextMenu {
                                        Button(action: {
                                            UIImageWriteToSavedPhotosAlbum(UIImage(named: resimAdi)!, nil, nil, nil)
                                        }, label: {
                                            HStack{
                                                Text("Kaydet")
                                                Image(systemName: "arrow.down")
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                            }
                                        })
                                    }
                                    
                                }
                            }
                        }
                    }.padding(.top)
                    
                }.padding()
            }
            
        }.background(Color("ArkaPlan").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    Home()
}
