//
//  ViewController.swift
//  iAhorcado
//
//  Created by CETYS on 17/10/17.
//  Copyright © 2017 CETYS. All rights reserved.
//

import UIKit


extension String {
    
    func charAt (at: Int) -> Character{
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self [charIndex]
    }

    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var pantalla: UILabel!
    
    var palabraOculta : String = "oculto"
    var numeroFallos : Int = 0
    let listaPalabras = ["APRUEBAME", "KAREL", "PONME.UN.10", "STAR.WARS"]
    
    
    @IBAction func Reinicio(_ sender: UIButton) {

       
    }
    @IBOutlet weak var imagen: UIImageView!
    
    @IBAction func letra(_ sender: UIButton) {
        
        sender.isEnabled = false
        chequeaLetra (caracter: sender.currentTitle!)
        
    }
    
    
    func eligePalabraOculta(){
        
        let posicion = Int(arc4random_uniform(UInt32(listaPalabras.count)))
        
        palabraOculta = listaPalabras[posicion]
        
    }
    
    func ponerGuiones(){
        var guiones : String = ""
        for i in 0 ..< palabraOculta.characters.count{
            guiones = guiones + "_ "
            
        }
        pantalla.text = guiones
    }
    
    func chequeaLetra(caracter:String){
        print(caracter)
        var palabraConGuiones : String = pantalla.text!
        
        if (palabraOculta.range(of: caracter) != nil){
            
            for var u in 0 ..< palabraOculta.characters.count{
                
                if palabraOculta.substring(with: u..<u+1) == caracter{
                    palabraConGuiones = palabraConGuiones.substring(to: u*2) + caracter + palabraConGuiones.substring(from: u*2+1)
                    
                    print(palabraConGuiones)
                }
                

            }
            pantalla.text = palabraConGuiones
            
        }
        else{
            numeroFallos += 1
            dibujaImagen(fallos: numeroFallos)
        }
        
        if palabraConGuiones.range(of: "_") != nil{
            
        }
        
        else{
            self.dibujaImagen(fallos: -1)
        }
        
    }
    
    func dibujaImagen(fallos:Int){
        switch fallos{
        case 0: imagen.image = UIImage(named: "ahorcado_0.png")
        case 1: imagen.image = UIImage(named: "ahorcado_1.png")
        case 2: imagen.image = UIImage(named: "ahorcado_2.png")
        case 3: imagen.image = UIImage(named: "ahorcado_3.png")
        case 4: imagen.image = UIImage(named: "ahorcado_4.png")
        case 5: imagen.image = UIImage(named: "ahorcado_5.png")
        case -1: imagen.image = UIImage(named: "acertasteTodo.png")
        default: imagen.image = UIImage(named: "ahorcado_fin.png")
        
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eligePalabraOculta()
        ponerGuiones()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

