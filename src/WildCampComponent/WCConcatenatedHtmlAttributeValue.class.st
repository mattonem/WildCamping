Class {
	#name : #WCConcatenatedHtmlAttributeValue,
	#superclass : #Object,
	#instVars : [
		'separator',
		'values'
	],
	#category : #WildCampComponent
}

{ #category : #'instance creation' }
WCConcatenatedHtmlAttributeValue class >> separator: aSeparator value: anFirstObject value: aSecondObject [
	^ self basicNew initializeWithSeparator: aSeparator value: anFirstObject value: aSecondObject
]

{ #category : #initialization }
WCConcatenatedHtmlAttributeValue >> encodeOn: aDocument [ 
	values
		do: [ :each | aDocument print: each ]
		separatedBy: [ aDocument print: separator ]
]

{ #category : #initialization }
WCConcatenatedHtmlAttributeValue >> initializeWithSeparator: aSeparator value: anFirstObject value: aSecondObject [
	self initialize.
	separator := aSeparator.
	values := OrderedCollection new: 4.
	values add: anFirstObject.
	values add: aSecondObject
]

{ #category : #initialization }
WCConcatenatedHtmlAttributeValue >> isConcatenatedHtmlAttributeValue [
	^ true
]
