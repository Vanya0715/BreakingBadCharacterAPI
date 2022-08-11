//
//  ContentView.swift
//  DemoApiFetch
//
//  Created by Divyansh Dwivedi on 11/08/22.
//

import SwiftUI

//MARK: - Character Endpoints

struct Info: Codable {
    var char_id: Int
    var name: String
    var birthday: String
    var status: String
    var appearance: [Int]
    var nickname: String
    var portrayed: String
    
}

//MARK: - Main View

struct ContentView: View {
    @State private var infos = [Info]()
    var body: some View {
       NavigationView{
            
            List (infos, id: \.char_id){ info in
                VStack(alignment: .leading) {
                    Text("Name: \(info.name)")
                    Text("Birthday: \(info.birthday)")
                    Text("Status: \(info.status)")
                    Text("Appearance: \(info.appearance.count)")
                    Text("Nickname: \(info.nickname)")
                    Text("Portrayed: \(info.portrayed)")
                }
                .font(.system(size: 16, weight: .regular, design: .serif))
                .padding()
                .frame( height: 120, alignment: .leading)
            }
            .task {
                //fetching data
                await fetchData()
            }.navigationTitle("Breaking Bad")
        }
    }
    
//MARK: - Create url, fetch data from url and decode
    
    func fetchData() async{
        // create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {
            print("code does not exist")
            return
        }
        
        // fetch data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // decoode the data
            if let decodedResponse = try? JSONDecoder().decode([Info].self, from: data) {
                infos = decodedResponse
            }
        } catch {
            print("Invalid Data ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



