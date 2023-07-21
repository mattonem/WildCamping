Class {
	#name : #WCBuilderCanvasJSTest,
	#superclass : #PjAppTestCase,
	#traits : 'WCBuilderCanvasTestTrait',
	#classTraits : 'WCBuilderCanvasTestTrait classTrait',
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #'suite parameters' }
WCBuilderCanvasJSTest class >> appClass [

	^ PjMinimalWebApplication
]

{ #category : #'as yet unclassified' }
WCBuilderCanvasJSTest >> assert: aBlock gives: aString [
	| html |
	html := self bridge evalBlock:  aBlock.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]
