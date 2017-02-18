//
//  Races.swift
//  RolePlayingCore
//
//  Created by Brian Arnold on 11/12/16.
//  Copyright © 2016-2017 Brian Arnold. All rights reserved.
//

import Foundation


public class Races {
    
    /// Accesses all of the races and subraces that have been loaded.
    public var allRacialTraits = [RacialTraits]()
    
    /// Accesses racial traits with subraces filtered out.
    public var races: [RacialTraits] {
        // Filter out races that have subraces
        return allRacialTraits.filter { print("\($0.name) isParent = \($0.subraces.isEmpty)"); return $0.subraces.isEmpty }
    }
    
    internal static let defaultRacesFile = "DefaultRaces"

    /// Creates default races.
    public convenience init(in bundle: Bundle = .main) {
        try! self.init(Races.defaultRacesFile, in: bundle)
    }
    
    /// Creates races from the specified races file.
    public init(_ racesFile: String, in bundle: Bundle) throws {
        try load(racesFile: racesFile, in: bundle)
    }
    
    internal func add(_ race: [String: Any]) {
        if let racialTraits = RacialTraits(from: race) {
            self.allRacialTraits.append(racialTraits)
            if let subraces = race["subraces"] as? [[String: Any]] {
                add(subraces, parent: racialTraits)
            }
        }
    }
    
    internal func add(_ subraces: [[String: Any]], parent:  RacialTraits) {
        for subrace in subraces {
            let subracialTraits = RacialTraits(from: subrace, parent: parent)
            self.allRacialTraits.append(subracialTraits)
            parent.subraces.append(subracialTraits)
        }
    }
    
    /// Adds races from the specified races file.
    public func load(racesFile: String, in bundle: Bundle = .main) throws {
        let jsonObject = try bundle.loadJSON(racesFile)
        
        let races = jsonObject["races"] as! [[String: Any]]
        for race in races {
            add(race)
        }
    }
    
}
