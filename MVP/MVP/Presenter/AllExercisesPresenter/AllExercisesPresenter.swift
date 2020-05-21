//
//  AllExercisesPresenter.swift
//  MVP
//
//  Created by admin on 20.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class AllExercisesPresenter: NSObject {
    
    unowned let view: AllExercisesViewControllerProtocol!
    
    static let reuseIdentifier = "cellOfExercise"
    
    var allExercises: [ExerciseModel]
    var filterAllExercises: [ExerciseModel]
    var title = "All Workouts"
    
    init(withView view: AllExercisesViewControllerProtocol) {
        self.view = view
        
        self.allExercises = CoreDataService.shared.fetchAllExercises()
        self.filterAllExercises = self.allExercises
        
        super.init()
    }
    
    //MARK: - Public
    
    func nameExercise(atIndex index: Int) -> String {
        return self.filterAllExercises[index].name
    }
    
    func filterAllExercises(byText text: String) -> Void {
        if text.count == 0 {
            self.filterAllExercises = self.allExercises
        } else {
            self.filterAllExercises = self.allExercises.filter({ (exerciseModel) -> Bool in
                return exerciseModel.name.lowercased().contains(text.lowercased())
            })
        }

        
        self.view.updateTableView()
    }
    
    func addExercise(atIndex index: Int) -> Void {
        var exerciseModel = self.filterAllExercises[index]
        exerciseModel.date = Date()
        
        CoreDataService.shared.addToMyExercise(exerciseModel: exerciseModel)
    }
    
}
