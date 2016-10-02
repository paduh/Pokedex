//
//  MainVC.swift
//  Pokedex
//
//  Created by Perfect Aduh on 30/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
        playSound()
    }
    
    func playSound(){
        
        let path = Bundle.main.path(forResource: "pokeaudio", ofType: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                
                pokemon.append(poke)
            }
            
          
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            let poke = pokemon[indexPath.row]
            
            cell.configuredCell(poke)
            return cell
        }
            return PokeCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 103, height: 104)
    }
    @IBAction func playSoundBtn(_ sender: UIButton) {
        
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            sender.alpha = 0.2
            
        } else {
            audioPlayer.play()
            sender.alpha = 1.0
        }
        
        }
}

