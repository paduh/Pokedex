//
//  PokeCell.swift
//  Pokedex
//
//  Created by Perfect Aduh on 30/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeThumb: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
   
    
    func configuredCell(_ pokemon: Pokemon){
        
        pokeName.text = pokemon.name.capitalized
        pokeThumb.image = UIImage(named: "\(pokemon.pokedexId)")
    }
}
