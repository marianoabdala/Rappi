import XCTest
@testable import Rappi

class SeriesListsProviderTests: XCTestCase {
    
    let provider = SeriesListsProvider(with: Client())
    
    func testGetPopular() {
        
        let waitExpectation = expectation(description: "Wait for fetch to return.")
        
        self.provider.getPopular(completionHandler: { items in
            
            XCTAssertEqual(items.count, 20)
            waitExpectation.fulfill()
            
        }, errorHandler: { _ in
            
            XCTFail()
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testGetTopRated() {
        
        let waitExpectation = expectation(description: "Wait for fetch to return.")
        
        self.provider.getTopRated(completionHandler: { items in
            
            XCTAssertEqual(items.count, 20)
            waitExpectation.fulfill()
            
        }, errorHandler: { _ in
            
            XCTFail()
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}
