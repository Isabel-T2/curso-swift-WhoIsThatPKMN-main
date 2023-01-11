//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Maria Isabel Torres Torres on 14/12/22.
//

import Foundation

struct PokemonManager{
    let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData){
                        print(pokemon)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name, imageURL: $0.url)
            }
            return pokemon
        } catch {
            return nil
        }
    }
}
