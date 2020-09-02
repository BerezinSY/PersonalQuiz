//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 31.08.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    // 1. Избавиться от кнопкп возврата
    // 2. Передать сюда массив с выбранными ответами
    // 3. Определить то животное, которое встречается чаще всего
    // 4. Отобразить результаты
    // 5. Подумать над логикой определени индекса в соответсвии с диапазоном
    
    
    @IBOutlet weak var animal: UILabel!
    @IBOutlet weak var animalDescription: UILabel!

    var answersChoosen: [Answer] = []
    private var definedAnimal: AnimalType!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        definedAnimal = defineAnimal(from: answersChoosen)
        animal.text = String(definedAnimal.rawValue)
        animalDescription.text = definedAnimal.definition
        
    }
    
    private func defineAnimal(from answers: [Answer]) -> AnimalType {
        var answers = answers
        var repeatedAnimals: [AnimalType: Int] = [:]
        var animalMaxRepeated: AnimalType?
        var repeatCounter = answers.count != 0 ? 1: 0
        
        answers.sort { (answerOne, answerTwo) -> Bool in
            answerOne.type.rawValue > answerTwo.type.rawValue
        }
        
        for index in 0..<answers.count - 1 {
            if answers[index].type == answers[index + 1].type {
                repeatCounter += 1
                repeatedAnimals.updateValue(repeatCounter, forKey: answers[index].type)
            } else {
                repeatCounter = 1
            }
        }
        
        let sortedAnimalsByDecrease = repeatedAnimals.sorted { (animalOne, animalTwo) -> Bool in
            animalOne.value < animalTwo.value
        }
        
        animalMaxRepeated = sortedAnimalsByDecrease.first?.key
        guard animalMaxRepeated != nil else { return .dog }
        return animalMaxRepeated!
    }
}
