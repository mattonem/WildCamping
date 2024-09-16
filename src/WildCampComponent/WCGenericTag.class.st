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

{ #category : 'as yet unclassified' }
WCGenericTag >> initializeWithTag: aString [
	self initialize.
	tag := aString
]

{ #category : 'accessing' }
WCGenericTag >> tag [
	^ tag
]
