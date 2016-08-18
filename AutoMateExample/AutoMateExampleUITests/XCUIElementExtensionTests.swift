//
//  XCUIElementExtensionTests.swift
//  AutoMateExample
//
//  Created by Pawel Szot on 17/08/16.
//  Copyright © 2016 PGS Software. All rights reserved.
//

import XCTest
import AutoMate

class XCUIElementExtensionTests: XCTestCase {
    let app = XCUIApplication()

    // MARK: Setup
    override func setUp() {
        super.setUp()
        app.launch()
    }

    // MARK: Tests
    func testIsVisible() {
        app.staticTexts["Scroll view"].tap()
        let button = app.buttons["ButtonBottom"]
        XCTAssertFalse(button.isVisible)
        button.tap()
        XCTAssert(button.isVisible)
    }

    func testSimpleSwipe() {
        app.staticTexts["Scroll view"].tap()
        let button = app.buttons["ButtonTop"]
        let scrollView = app.scrollViews.element
        XCTAssert(button.hittable)

        scrollView.swipe(from: CGVector(dx: 0.5, dy: 0.9), to: CGVector(dx: 0.5, dy: 0.1))

        XCTAssertFalse(button.hittable)
    }

    func testComplexSwipe() {
        app.staticTexts["Scroll view"].tap()
        let button1 = app.buttons["ButtonTop"]
        let button2 = app.buttons["ButtonBottom"]
        let scrollView = app.scrollViews.element
        XCTAssert(button1.hittable && !button2.hittable)

        scrollView.swipe(to: button2)
        XCTAssertFalse(button1.hittable && button2.hittable)

        scrollView.swipe(to: button1)
        XCTAssert(button1.hittable && !button2.hittable)
    }

    func testComplexSwipeWithKeyboard() {
        app.staticTexts["Scroll view"].tap()
        app.textFields.element.tap()
        app.textFields.element.typeText("x")

        let buttonTop = app.buttons["ButtonTop"]
        let buttonMiddle1 = app.buttons["ButtonMiddle1"]
        let buttonMiddle2 = app.buttons["ButtonMiddle2"]
        let scrollView = app.scrollViews.element

        XCTAssert(buttonTop.hittable && !buttonMiddle1.hittable && !buttonMiddle2.hittable)

        scrollView.swipe(to: buttonMiddle1)
        XCTAssert(buttonMiddle1.hittable)

        scrollView.swipe(to: buttonMiddle2)
        XCTAssert(buttonMiddle2.hittable)

        scrollView.swipe(to: buttonMiddle1)
        XCTAssert(buttonMiddle1.hittable)
    }

    func testClearTextField() {
        app.cells["Text input"].tap()

        let textField = app.textFields.element
        textField.tap()
        textField.typeText("x")
        XCTAssertEqual(textField.value as? String, "x")
        textField.clearTextField()
        XCTAssertEqual(textField.value as? String, "")
    }

    func testClearAndType() {
        app.cells["Text input"].tap()

        let textField = app.textFields.element
        textField.tap()
        textField.typeText("x")
        XCTAssertEqual(textField.value as? String, "x")
        textField.clearAndType("d")
        XCTAssertEqual(textField.value as? String, "d")
    }

    func testTapWithOffset() {
        XCTAssert(app.tables.element.exists)
        let title = app.staticTexts["Scroll view"]
        XCTAssert(title.exists)

        // tap cell by using offset only
        app.tapWithOffset(CGVector(dx: 0.5, dy: 0.3))
        // cell pushed view controller, title no longer visible
        XCTAssertFalse(title.exists)
    }

    /// This test relies on permission being cleared before starting the test. This is currently done in "Run script" build phase.
    func testSystemAlertButton() {
        addUIInterruptionMonitorWithDescription("Location") { (element) -> Bool in
            element.tapLeftButtonOnSystemAlert()
            return true
        }
        app.staticTexts["Location"].tap()

        // interruption won't happen without some kind of action
        app.tap()

        waitForElementToExist(app.staticTexts["Denied"])
    }

}
