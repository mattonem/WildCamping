Class {
	#name : 'WCAppTestCase',
	#superclass : 'PjAppTestCase',
	#category : 'WildCampComponent-Tests',
	#package : 'WildCampComponent',
	#tag : 'Tests'
}

{ #category : 'suite parameters' }
WCAppTestCase class >> appClass [

	^ PjMinimalWebApplication
]

{ #category : 'suite parameters' }
WCAppTestCase class >> isAbstract [
	^ self name = #WCAppTestCase
]

{ #category : 'tests-tags-anchors' }
WCAppTestCase >> assert: aBlock gives: aString [
	| html |
	html := self bridge evalBlock:  aBlock.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]
