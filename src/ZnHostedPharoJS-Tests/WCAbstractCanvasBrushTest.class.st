Class {
	#name : #WCAbstractCanvasBrushTest,
	#superclass : #TestCase,
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #testing }
WCAbstractCanvasBrushTest class >> isAbstract [
	^ self name = #WAAbstractCanvasBrushTest
]

{ #category : #accessing }
WCAbstractCanvasBrushTest class >> packageNamesUnderTest [
	^ #('Seaside-Canvas')
]

{ #category : #private }
WCAbstractCanvasBrushTest >> assert: aBlock gives: aString [
	| html |
	html := self builder
		render: aBlock.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]

{ #category : #private }
WCAbstractCanvasBrushTest >> builder [
	^ WCHtmlCanvas builder
]
