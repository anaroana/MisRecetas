//
//  ViewController.swift
//  MisRecetas
//
//  Created by Ana Rocha on 12/12/17.
//  Copyright © 2017 Kite. All rights reserved.
//

import UIKit

class ViewController: UITableViewController { /*UIViewController, UITableViewDataSource, UITableViewDelegate*/
    var recipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initRecetario()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true //oculta la barra al hacer swipe (arrastrar el dedo sobre la pantalla para bajar la barra)
    }
    func initRecetario(){
        agregaReceta(name: "Tortilla de patatas",image: #imageLiteral(resourceName: "tortilla"), time: 20, ingredients: ["Patatas","Huevos","Cebolla"], steps: ["Pelar las patatas y la cebolla","Cortar las patatas y la cebolla y sofreir", "Batir los huevos e incorporarlos durante 1 minuto"] )
        agregaReceta(name: "Pizza Margarita",image: #imageLiteral(resourceName: "pizza"), time: 60, ingredients: ["Harina", "Levadura", "Aceite", "Sal", "Salsa de Tomate", "Queso"], steps: ["Mezclar harina, levadura, aceite y sal", "Dejar reposar la masa 30 minutos", "Extendemos la masa encima de una bandeja y añadimos los demas ingredientes", "Hornear durante 15 minutos"])
        agregaReceta(name: "Hamburguesa con queso", image: #imageLiteral(resourceName: "hamburgesa"), time: 10, ingredients:["Pan", "Lechuga", "Jitomate", "Queso", "Carne"], steps: ["Poner al fuego la carne al gusto", "Poner los ingredientes entre los panes"] )
        agregaReceta(name: "Ensalada César", image: #imageLiteral(resourceName: "ensalada"), time: 15, ingredients: ["Lechuga", "Tomate", "Cebolla", "Pimientos", "Salsa Cesar", "Pollo"], steps: ["Limpiar verduras y picarlas", "Cocer el pollo al gusto", "Juntar todos los ingredientes y servir con salsa por encima"])
        agregaReceta(name: "Hummus", image: #imageLiteral(resourceName: "hummus"), time: 30, ingredients: ["Garbanzos", "Jugo de Limón", "Aceite de Oliva", "Sal", "Chipotle"], steps: ["Cocer los garbanzos en agua", "Filtrar los garbanzos", "Añadir garbanzos, el chipotle y la Sal ala licuadora", "Ir mezclando agregando pequeños chorros de aceite de oliva y de limón hasta lograr una mezcla homogenea"])
        agregaReceta(name: "Fresas con Crema", image: #imageLiteral(resourceName: "fresas"), time: 15, ingredients: ["Fresas", "Crema", "Azucar"], steps: ["Lavar y desinfectar las fresas", "Juntar las fresas con la Crema", "Añadir azucar al gusto"])
        agregaReceta(name: "Makis", image: #imageLiteral(resourceName: "sushi"), time: 90, ingredients: ["Algas Nori Tostadas", "Arroz", "Salsa de Soya", "Pepino", "Zanahoria", "Aguacate", "Camarón", "Surimi", "Carne de Res, Pollo o Pescado"], steps: ["Cocer el arroz con poca agua", "Freir la carne al gusto", "Picar en Tiras pepino, zanahoria, aguacate, surimi y la carne", "Estender dos cucharadas de arroz sobre un alga", "Agregar los ingredientes y enrollar", "Rebanar el rollo" ])
        agregaReceta(name: "Salmon", image: #imageLiteral(resourceName: "salmon"), time: 45, ingredients: [], steps: [])
        agregaReceta(name: "Pan Dulce", image: #imageLiteral(resourceName: "pan"), time: 120, ingredients: [], steps: [])
        
    }
    func agregaReceta(name: String, image: UIImage,time: Int, ingredients: [String], steps: [String]){
        recipes.append(Recipe(name: name, image: image, time: time, ingredients: ingredients, steps:steps))
    }
    //ocultar la barra de estado
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    
    //Numero de secciones o columnas
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Numero total de filas, número de celdas que mostraremos en nuestra tabla
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    //datos que mostraremos en cada celda y se ejecutará tantas veces como celdas tenga la única sección de nuestra tabla
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = recipes[indexPath.row]
        let celID = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! RecipeCell
        //se reutilizan las cells, solo carga en memoria las que son visibles para el usuario
        /* let cell = UITableViewCell(style: .subtitle, reuseIdentifier: celID)*/
        cell.nameLabel.text = recipe.name
        cell.thumbnailImageView.image = recipe.image
        cell.timeLabel.text = "\(recipe.time!) minutos"
        cell.ingredientsLabel.text = "Ingredientes: \(recipe.ingredients.count)"

        /*
        if recipe.isFavourite{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        /*
        cell.thumbnailImageView.layer.cornerRadius = 42 //capa circular //cell.thumbnailImageView.layer.borderWidth/2
        cell.thumbnailImageView.clipsToBounds = true // recortar los bordes
         */
        /*
        cell.textLabel?.text = recipe.name
        cell.imageView?.image = recipe.image
         */
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            self.recipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
 
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let shareDefaultText = "Estoy mirando la receta \(self.recipes[indexPath.row].name!) en la app del curso de Mis Recetas"
            let activityViewController = UIActivityViewController(activityItems: [shareDefaultText,self.recipes[indexPath.row].image], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor(red: 30/255, green: 164/255, blue: 253/255, alpha: 1)
        //Borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Eliminar") { (action, indexPath) in
            self.recipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
         deleteAction.backgroundColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
        return [shareAction, deleteAction]
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        /*
        let recipe = recipes[indexPath.row]
        let alertController = UIAlertController(title: recipe.name, message: "Valora este plato", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        var favouriteActionTitle = "Me gusta"
        var favouriteActionStyle = UIAlertActionStyle.default
        if recipe.isFavourite{
            favouriteActionTitle = "No me gusta"
            favouriteActionStyle = UIAlertActionStyle.destructive
        }
        let favouriteAction = UIAlertAction(title: favouriteActionTitle, style: favouriteActionStyle) { (action) in
            let recipe = self.recipes[indexPath.row]
            recipe.isFavourite = !recipe.isFavourite
            self.tableView.reloadData() //Refresca toda la tableView
        }
        alertController.addAction(favouriteAction)
        self.present(alertController, animated: true, completion: nil)
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectRecipe = recipes[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.recipe = selectRecipe
            }
        }
    }

    
}

