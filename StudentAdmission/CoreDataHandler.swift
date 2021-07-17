//
//  CoreDataHandler.swift
//  StudentAdmission
//
//  Created by Sandhya Baghel on 11/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler
{
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext?
    
    private init()
    {
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save()
    {
        appDelegate.saveContext()
    }
    
    func insert(name:String , email:String, mobile:String , pwd:String, completion: @escaping () -> Void)
    {
        let stud = Student(context: managedObjectContext!)
        stud.name = name
        stud.email = email
        stud.mobile = mobile
        stud.pwd = pwd
        
        save()
        completion()
    }
    func update(stud:Student, name:String, email:String ,mobile:String , pwd:String, completion: @escaping () -> Void)
    {
        stud.email = email
        stud.name = name
        stud.mobile = mobile
        stud.pwd = pwd
        save()
        completion()
    }
    
    func changepwd(stud:Student , pwd:String, completion: @escaping () -> Void)
    {
        stud.pwd = pwd
        save()
        completion()
    }
    
    func delete(stud:Student, completion: @escaping () -> Void)
    {
        managedObjectContext!.delete(stud)
        save()
        completion()
    }
    
    func fetch() -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do
        {
            let studArray = try managedObjectContext?.fetch(fetchRequest)

            return studArray!
        } catch {
            print(error)
            let studArray = [Student]()
            return studArray
        }
    }
}
