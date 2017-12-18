//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Ana Rocha on 13/12/17.
//  Copyright © 2017 Kite. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var recipeImageView: UIImageView!
    var recipe: Recipe!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ratingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = recipe.name //titulo de la navigation bar al querer retroceder
        
        self.recipeImageView.image = self.recipe.image
        
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero) //todo lo que venga despues de la ultima celda desaparesca
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        self.tableView.estimatedRowHeight = 44 //tamaño estimado
        self.tableView.rowHeight = UITableViewAutomaticDimension //ajuste automatico del tamaño de la celda
        
        self.ratingButton.setImage(UIImage(named:self.recipe.rating), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false //desactiva la bandera para que se puedan ocultar
        navigationController?.setNavigationBarHidden(false, animated: true) // vuelve a mostrar la barra
    }
 
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewVC = segue.source as? ReviewViewController{
            if let ratingStr: String = reviewVC.ratingSelected{
                self.recipe.rating = ratingStr
                self.ratingButton.setImage(UIImage(named:self.recipe.rating), for: .normal)
            }
        }
    }
    
}

//MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 2
            case 1:
                return self.recipe.ingredients.count
            case 2:
                return self.recipe.steps.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell", for: indexPath) as! RecipeDetailViewCell
        cell.backgroundColor = UIColor.clear //color transparente con 0 alpha
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    cell.keyLabel.text = "Nombre:"
                    cell.valueLabel.text = self.recipe.name
                case 1:
                    cell.keyLabel.text = "Tiempo:"
                    cell.valueLabel.text = "\(self.recipe.time!) minutos"
                default:
                    break
            }
        case 1:
            cell.keyLabel.text = ""
            cell.valueLabel.text = " \(self.recipe.ingredients[indexPath.row])"
        case 2:
            cell.keyLabel.text = ""
            cell.keyLabel.textAlignment = NSTextAlignment.right
            cell.valueLabel.text = "\(self.recipe.steps[indexPath.row])"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break
        }
        return title
    }
    
}
extension DetailViewController: UITableViewDelegate{
    
}


