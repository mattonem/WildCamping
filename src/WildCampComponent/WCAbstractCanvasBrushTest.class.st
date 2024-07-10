Class {
	#name : 'WCAbstractCanvasBrushTest',
	#superclass : 'TestCase',
	#category : 'WildCampComponent-Tests',
	#package : 'WildCampComponent',
	#tag : 'Tests'
}

{ #category : 'testing' }
WCAbstractCanvasBrushTest class >> isAbstract [
	^ self name = #WCAbstractCanvasBrushTest
]

{ #category : 'private' }
WCAbstractCanvasBrushTest >> assert: aBlock gives: aString [
	| html |
	html := aBlock value.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]
