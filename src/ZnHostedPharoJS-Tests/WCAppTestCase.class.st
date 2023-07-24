Class {
	#name : #WCAppTestCase,
	#superclass : #PjAppTestCase,
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #'suite parameters' }
WCAppTestCase class >> appClass [

	^ PjMinimalWebApplication
]

{ #category : #'tests-tags-anchors' }
WCAppTestCase >> assert: aBlock gives: aString [
	| html |
	html := self bridge evalBlock:  aBlock.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]
