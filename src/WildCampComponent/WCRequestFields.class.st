Class {
	#name : #WCRequestFields,
	#superclass : #Object,
	#instVars : [
		'dictionary'
	],
	#category : #WildCampComponent
}

{ #category : #accessing }
WCRequestFields >> at: aString add: anUndefinedObject [

	^ (self dictionary at: aString ifAbsentPut: [ OrderedCollection new ]) 
		  add: anUndefinedObject
]

{ #category : #accessing }
WCRequestFields >> dictionary [

	^ dictionary ifNil: [ dictionary := Dictionary new ]
]

{ #category : #testing }
WCRequestFields >> isEmpty [

	^ dictionary isEmptyOrNil
]

{ #category : #enumerating }
WCRequestFields >> keysAndValuesDo: aFullBlockClosure [

	^ self dictionary keysAndValuesDo: [ :aKey :aColl |
		  aColl do: [ :aVal | aFullBlockClosure value: aKey value: aVal ] ]
]
