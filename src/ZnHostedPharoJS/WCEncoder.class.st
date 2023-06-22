Class {
	#name : #WCEncoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'instance creation' }
WCEncoder class >> on: aStream [
	^ self basicNew initializeOn: aStream
]

{ #category : #initialization }
WCEncoder >> initializeOn: aStream [
	self initialize.
	stream := aStream
]

{ #category : #accessing }
WCEncoder >> nextPut: aCharacter [ 
	self subclassResponsibility
]

{ #category : #accessing }
WCEncoder >> nextPutAll: aString [
	self subclassResponsibility
]
