"
A ZnHostedHelloWorldAppTest is a test class for testing the behavior of ZnHostedHelloWorldApp
"
Class {
	#name : 'WCHelloWorldAppTest',
	#superclass : 'PjWebAppTestCase',
	#category : 'WildCampComponent-ExcludedTests',
	#package : 'WildCampComponent',
	#tag : 'ExcludedTests'
}

{ #category : 'suite parameters' }
WCHelloWorldAppTest class >> appClass [
 
	^ WCHelloWorldApp
]

{ #category : 'tests' }
WCHelloWorldAppTest >> setUp [

	super setUp
]

{ #category : 'tests' }
WCHelloWorldAppTest >> tearDown [

	super tearDown
]

{ #category : 'tests' }
WCHelloWorldAppTest >> testHelloWorld [
	self waitUntil: [ document readyState = 'complete' ].
	(self app document querySelector: 'input') value: 'Auto Test'.
	(self app document querySelector: 'button') click.
	
	self
		assert: (self app document querySelector: 'p#main') innerHTML
		equals: 'Hello Auto Test'
]
