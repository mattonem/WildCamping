Class {
	#name : #WCGenericTag,
	#superclass : #WCTagBrush,
	#instVars : [
		'tag'
	],
	#category : #WildCampComponent
}

{ #category : #accessing }
WCGenericTag class >> tag: aString [
	^ self basicNew initializeWithTag: aString; yourself
]

{ #category : #initialization }
WCGenericTag >> initializeWithTag: aString [
	self initialize.
	tag := aString
]

{ #category : #accessing }
WCGenericTag >> tag [
	^ tag
]
