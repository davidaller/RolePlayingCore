//
//  PlayersTests.swift
//  RolePlayingCore
//
//  Created by Brian Arnold on 2/18/17.
//  Copyright © 2017 Brian Arnold. All rights reserved.
//

import XCTest

import RolePlayingCore

class PlayersTests: XCTestCase {
    
    var classes: Classes!
    var races: Races!
    
    override func setUp() {
        let bundle = Bundle(for: PlayersTests.self)
        
        // TODO: Need to initialize UnitCurrency before creating Money instances in Player class.
        try! UnitCurrency.load("TestCurrencies", in: bundle)

        // TODO: if these fail, it will kill the unit test run.
        classes = try! Classes("TestClasses", in: bundle)
        races = try! Races("TestRaces", in: bundle)
    }
    
    func testPlayers() {
        let bundle = Bundle(for: PlayersTests.self)

        let players = Players(classes: classes, races: races)
        do {
            try players.load("TestPlayers", in: bundle)
        }
        catch let error {
            XCTFail("players.load failed, error \(error)")
        }
        XCTAssertEqual(players.players.count, 2, "players count")
        XCTAssertEqual(players.count, 2, "players count")

        let removedPlayer = players[0]!
        players.remove(at: 0)
        XCTAssertEqual(players.count, 1, "players count")
        
        players.insert(removedPlayer, at: 1)
        XCTAssertEqual(players.count, 2, "players count")
        XCTAssertTrue(players[1]! === removedPlayer, "players count")
    }
    
    func testMissingTraits() {
        let bundle = Bundle(for: PlayersTests.self)
        
        let players = Players(classes: classes, races: races)
        do {
            try players.load("InvalidClassPlayers", in: bundle)
            XCTFail("players.load should have failed")
        }
        catch let error {
            print("players.load correctly threw an error \(error)")
        }
        XCTAssertEqual(players.players.count, 0, "players count")
        
        do {
            try players.load("InvalidRacePlayers", in: bundle)
            XCTFail("players.load should have failed")
        }
        catch let error {
            print("players.load correctly threw an error \(error)")
        }
        XCTAssertEqual(players.players.count, 0, "players count")
        
        do {
            try players.load("MissingClassPlayers", in: bundle)
            XCTFail("players.load should have failed")
        }
        catch let error {
            print("players.load correctly threw an error \(error)")
        }
        XCTAssertEqual(players.players.count, 0, "players count")

        do {
            try players.load("MissingRacePlayers", in: bundle)
            XCTFail("players.load should have failed")
        }
        catch let error {
            print("players.load correctly threw an error \(error)")
        }
        XCTAssertEqual(players.players.count, 0, "players count")

    }
    
    
}
