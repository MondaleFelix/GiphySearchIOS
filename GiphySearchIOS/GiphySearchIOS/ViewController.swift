//
//  ViewController.swift
//  GiphySearchIOS
//
//  Created by Mondale on 4/6/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        var network = GifNetwork()
        var gifs: [Gif] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            setup()
        }
        
        func setup() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .black
            searchBar.searchTextField.delegate = self
            searchBar.searchTextField.placeholder = "What's your favorite gif?"
            searchBar.returnKeyType = .search
        }
        
    //    func searchGifs(searchText: String) {
    //        network.fetchGifs(searchTerm: searchText)
    //    }
    //
        func fetchGifs(searchText: String) {
            network.fetchGifs(searchTerm: searchText) { results in
                if results != nil {
                    print(results!.gifs.count)
                    self.gifs = results!.gifs
                    print(self.gifs)
                    self.tableView.reloadData()
                }
            }
        }
        


    }


    // MARK: - Tableview functions
    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return gifs.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell", for: indexPath) as! GifCell
            cell.gif = gifs[indexPath.row]
            return cell
        }
    }

    // MARK: - Search bar functions
    extension ViewController: UISearchTextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if textField.text != nil {
                print(textField.text!)
                fetchGifs(searchText: textField.text!)
            }
            return true
        }
    }
