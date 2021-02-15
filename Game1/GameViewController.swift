//
//  GameViewController.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-09.
//

import UIKit

class GameViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var collectionViewDataSource = [String]()
    var collectionView: UICollectionView?
    var collectionViewPortraitConstraints = [NSLayoutConstraint]()
    var collectionViewLanscapeConstraints = [NSLayoutConstraint]()
    
    var columnsNumber: Int!
    var rowsNumber: Int!
    
    var holeX: Int!
    var holeY: Int!
    
    var boxX: Int!
    var boxY: Int!
    
    var personX: Int!
    var personY: Int!
    
    var field: Field?
    var hole: Hole?
    var box: Box?
    var mario: Person?
    var game: MoveBoxGame?

    var buttonsStackView = UIStackView()
    var buttonsStackViewPortraitConstraints = [NSLayoutConstraint]()
    var buttonsStackViewLanscapeConstraints = [NSLayoutConstraint]()
    var topButtonStackView = UIStackView()
    var leftRightButtonsStackView = UIStackView()
    var bottomButtonStackView = UIStackView()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        createCollectionView()
        createButtons()
        startGame()
        
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {

        if(UIDevice.current.orientation.isLandscape){
            
            NSLayoutConstraint.deactivate(collectionViewPortraitConstraints)
            NSLayoutConstraint.deactivate(buttonsStackViewPortraitConstraints)
            
            collectionViewLanscapeConstraints.append(collectionView!.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1))
            collectionViewLanscapeConstraints.append(collectionView!.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1))
            collectionViewLanscapeConstraints.append(collectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
            collectionViewLanscapeConstraints.append(collectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
            
            buttonsStackViewLanscapeConstraints.append(buttonsStackView.leadingAnchor.constraint(equalTo: collectionView!.trailingAnchor))
            buttonsStackViewLanscapeConstraints.append(buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
            buttonsStackViewLanscapeConstraints.append(buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
            
            NSLayoutConstraint.activate(collectionViewLanscapeConstraints)
            NSLayoutConstraint.activate(buttonsStackViewLanscapeConstraints)
            
        } else if(UIDevice.current.orientation.isPortrait){
            NSLayoutConstraint.deactivate(collectionViewLanscapeConstraints)
            NSLayoutConstraint.deactivate(buttonsStackViewLanscapeConstraints)
            
            NSLayoutConstraint.activate(collectionViewPortraitConstraints)
            NSLayoutConstraint.activate(buttonsStackViewPortraitConstraints)
            
        }

    }
    
    
    func startGame() {
        field = Field(width: columnsNumber, height: rowsNumber)
        hole = Hole(coords: Point(x: holeX, y: holeY))
        box = Box(gameField: field!, hole: hole!, coords: Point(x: boxX, y: boxY))
        mario = Person(gameField: field!, box: box!, hole: hole!, coords: Point(x: personX, y: personY))
        game = MoveBoxGame(gameField: field!, box: box!, person: mario!, hole: hole!)
        
        collectionViewDataSource = game!.printCurrentFieldState()
        collectionView?.reloadData()

    }
    
    func refreshGameField() {

        collectionViewDataSource = game?.printCurrentFieldState() ?? collectionViewDataSource
        collectionView?.reloadData()
        
        if(box?.hitTheHole == true){
            showWonGameAlert()
        } else if(box?.deadEnd == true){
            showLoseGameAlert()
        }
    }
    
    func showWonGameAlert() {
        
        let alert = UIAlertController(title: "Move Box Game", message: "You won!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: {(action) in
            self.startGame()
        }))
        alert.addAction(UIAlertAction(title: "Change Settings", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    func showLoseGameAlert() {
        
        let alert = UIAlertController(title: "Move Box Game", message: "Нет смысла продолжать. Попробуйте еще раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: {(action) in
            self.startGame()
        }))
        alert.addAction(UIAlertAction(title: "Change Settings", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        guard let collectionView = self.collectionView else {return}
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionViewPortraitConstraints.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        collectionViewPortraitConstraints.append(collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        collectionViewPortraitConstraints.append(collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))

        
        NSLayoutConstraint.activate(collectionViewPortraitConstraints)
        
      }
    
    
    func createButtons() {
        
        let buttonUp = UIButton(frame: CGRect(x: topButtonStackView.bounds.width / 2, y: 0, width: 40, height: 40))
        let buttonDown = UIButton(frame: CGRect(x: bottomButtonStackView.bounds.width / 2, y: 0, width: 40, height: 40))
        let buttonRight = UIButton(frame: CGRect(x: leftRightButtonsStackView.bounds.width, y: 0, width: 40, height: 40))
        let buttonLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        buttonUp.setTitle("🔼", for: .normal)
        buttonUp.addTarget(self, action: #selector(self.buttonUpClicked(sender:)), for: .touchUpInside)
                
        buttonDown.setTitle("🔽", for: .normal)
        buttonDown.addTarget(self, action: #selector(self.buttonDownClicked(sender:)), for: .touchUpInside)

        buttonRight.setTitle("▶️", for: .normal)
        buttonRight.addTarget(self, action: #selector(self.buttonRightClicked(sender:)), for: .touchUpInside)
        
        buttonLeft.setTitle("◀️", for: .normal)
        buttonLeft.addTarget(self, action: #selector(self.buttonLeftClicked(sender:)), for: .touchUpInside)
        
        
        configureTopButtonStackView()
        configureLeftRightButtonsStackView()
        configureBottomButtonStackView()
        
        setTopButtonStackViewConstrains()
        setLeftRightButtonsStackViewConstrains()
        setBottomButtonStackViewConstrains()
        
        topButtonStackView.addArrangedSubview(buttonUp)
        leftRightButtonsStackView.addArrangedSubview(buttonLeft)
        leftRightButtonsStackView.addArrangedSubview(buttonRight)
        bottomButtonStackView.addArrangedSubview(buttonDown)
        
        configureButtonsStackView()
        setButtonsStackViewConstrains()
        
        
    }
    
    @objc func buttonUpClicked(sender: UIButton) {
        mario?.go(direction: .up)
        refreshGameField()
    }
    
    @objc func buttonRightClicked(sender: UIButton) {
        mario?.go(direction: .right)
        refreshGameField()
    }
        
    @objc func buttonDownClicked(sender: UIButton) {
        mario?.go(direction: .down)
        refreshGameField()
    }
    
    @objc func buttonLeftClicked(sender: UIButton) {
        mario?.go(direction: .left)
        refreshGameField()
    }

    func configureButtonsStackView() {
        self.view.addSubview(buttonsStackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        
        setButtonsStackViewConstrains()
    }
    
    func setButtonsStackViewConstrains() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStackViewPortraitConstraints.append(buttonsStackView.topAnchor.constraint(equalTo: collectionView!.bottomAnchor))
        buttonsStackViewPortraitConstraints.append(buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        buttonsStackViewPortraitConstraints.append(buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        buttonsStackViewPortraitConstraints.append(buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(buttonsStackViewPortraitConstraints)
    }
    
    
    //Buttons SubStackViews
    func configureTopButtonStackView() {
        buttonsStackView.addSubview(topButtonStackView)
        topButtonStackView.axis = .vertical
        topButtonStackView.distribution = .fillEqually
        setTopButtonStackViewConstrains()
    }
    
    func setTopButtonStackViewConstrains() {
        topButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        topButtonStackView.topAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: 0).isActive = true
        topButtonStackView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: 0).isActive = true
        topButtonStackView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor, constant: 0).isActive = true
    }
    
    func configureLeftRightButtonsStackView() {
        buttonsStackView.addSubview(leftRightButtonsStackView)
        leftRightButtonsStackView.axis = .horizontal
        leftRightButtonsStackView.distribution = .fillEqually
        setLeftRightButtonsStackViewConstrains()
    }
    
    func setLeftRightButtonsStackViewConstrains() {
        leftRightButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        leftRightButtonsStackView.topAnchor.constraint(equalTo: topButtonStackView.bottomAnchor, constant: 0).isActive = true
        leftRightButtonsStackView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: 0).isActive = true
        leftRightButtonsStackView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor, constant: 0).isActive = true
    }
    
    func configureBottomButtonStackView() {
        buttonsStackView.addSubview(bottomButtonStackView)
        bottomButtonStackView.axis = .vertical
        bottomButtonStackView.distribution = .fillEqually
        setBottomButtonStackViewConstrains()
    }
    
    func setBottomButtonStackViewConstrains() {
        bottomButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonStackView.topAnchor.constraint(equalTo: leftRightButtonsStackView.bottomAnchor, constant: 0).isActive = true
        bottomButtonStackView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: 0).isActive = true
        bottomButtonStackView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor, constant: 0).isActive = true
        bottomButtonStackView.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 0).isActive = true
    }

}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell {
              cell.setModeltoUI(model: self.collectionViewDataSource[indexPath.row])
              return cell
            }
            return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:  collectionView.frame.width / CGFloat(columnsNumber + 2), height: collectionView.frame.width / CGFloat(rowsNumber + 2) )
      }
}

