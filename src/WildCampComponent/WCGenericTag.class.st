Class {
	#name : 'WCGenericTag',
	#superclass : 'WCTagBrush',
	#instVars : [
		'tag'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'as yet unclassified' }
WCGenericTag class >> tag: aString [
	^ self basicNew initializeWithTag: aString; yourself
]

{ #category : 'accessing' }
WCGenericTag >> height: anInteger [
	self attributeAt: 'height' put: anInteger
]

{ #category : 'as yet unclassified' }
WCGenericTag >> initializeWithTag: aString [
	self initialize.
	tag := aString
]

{ #category : 'accessing' }
WCGenericTag >> tag [
	^ tag
]

{ #category : 'accessing' }
WCGenericTag >> width: anInteger [
	self attributeAt: 'width' put: anInteger
]
