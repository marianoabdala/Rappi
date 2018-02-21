import XCTest
@testable import Rappi

class SeriesDetailProviderTests: XCTestCase {
    
    let listProvider = SeriesListsProvider(with: Client())
    let detailProvider = SeriesDetailProvider(with: Client())
    
    func testGetMostPopularDetail() {
        
        let waitExpectation = expectation(description: "Wait for fetch to return.")
        
        self.listProvider.getPopular(completionHandler: { items in
            
            XCTAssertEqual(items.count, 20)
            
            guard let first = items.first else {
                
                XCTFail()
                return
            }
            
            self.detailProvider.getDetails(for: first, completionHandler: { _ in
                
                waitExpectation.fulfill()
                
            }, errorHandler: { _ in
                
                XCTFail()
            })
            
        }, errorHandler: { _ in
            
            XCTFail()
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}

