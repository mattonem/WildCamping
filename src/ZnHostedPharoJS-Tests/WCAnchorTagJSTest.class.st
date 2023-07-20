Class {
	#name : #WCAnchorTagJSTest,
	#superclass : #PjAppTestCase,
	#traits : 'WCAnchorTagTestTrait',
	#classTraits : 'WCAnchorTagTestTrait classTrait',
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #'suite parameters' }
WCAnchorTagJSTest class >> appClass [

	^ PjMinimalWebApplication
]

{ #category : #'tests-tags-anchors' }
WCAnchorTagJSTest >> assert: aBlock gives: aString [
	| html |
	html := self bridge evalBlock:  aBlock.
	self
		assert: html = aString
		description:	 'Expected: ', aString printString, ', Actual: ', html printString
		resumable: true
]

{ #category : #'tests-tags-anchors' }
WCAnchorTagJSTest >> builder [
	^ WCHtmlCanvas builder
]
