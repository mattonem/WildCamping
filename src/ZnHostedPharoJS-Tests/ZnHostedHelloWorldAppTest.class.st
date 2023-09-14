"
A ZnHostedHelloWorldAppTest is a test class for testing the behavior of ZnHostedHelloWorldApp
"
Class {
	#name : #ZnHostedHelloWorldAppTest,
	#superclass : #PjWebAppTestCase,
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #'suite parameters' }
ZnHostedHelloWorldAppTest class >> appClass [
	^ZnHostedHelloWorldApp
]

{ #category : #tests }
ZnHostedHelloWorldAppTest >> setUp [
	super setUp.
	
]

{ #category : #tests }
ZnHostedHelloWorldAppTest >> testHelloWorld [
	(self app document querySelector: 'input') value: 'Auto Test'.
	(self app document querySelector: 'button') click.
	self assert: (self app document querySelector: 'p#main') innerHTML equals: 'Hello Auto Test'.
]

{ #category : #tests }
ZnHostedHelloWorldAppTest >> testMap [

	^ (self app componentNamed: #map) bounds equals: 0 @ 0
]
