Class {
	#name : #WCUrlEncoder,
	#superclass : #WCEncoder,
	#classVars : [
		'table'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #private }
WCUrlEncoder class >> encode: aCharacter on: aStream [ 
	('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~' includes: aCharacter) ifTrue: [ ^ aStream nextPut: aCharacter ].
	aStream nextPut: $%.
	self print: aCharacter greaseInteger on: aStream
]

{ #category : #initialization }
WCUrlEncoder class >> initialize [
	self initializeTable
]

{ #category : #initialization }
WCUrlEncoder class >> initializeTable [
	"Initializes the encoding table."
	| stream characterLimit |
	characterLimit := self maximumCharacterValue.
	"character values at zero so we need to add 1"
	table := Array new: characterLimit + 1.
	stream := WriteStream on: (String new: 6).
	0 to: characterLimit do: [ :index | 
		| character value |
		character := Character codePoint: index.
		self encode: character on: stream reset.
		"Smalltalk indices are one based but character values start at 0"
		value := stream contents = (String with: character)
			ifTrue: [ nil ]
			ifFalse: [ stream contents ].
		table at: index + 1 put: value ]
]

{ #category : #initialization }
WCUrlEncoder class >> maximumCharacterValue [
	"String to byte encoding has already happened in the server."
	
	^ 16rFF
]

{ #category : #private }
WCUrlEncoder class >> print: aNumber on: aStream [
	aStream << (aNumber printStringBase: 16 nDigits: 2)
]

{ #category : #accessing }
WCUrlEncoder >> maximumCharacterValue [
	"find the maximum value of a character that we can instantiate, for Squeak 3.7 this is 255"
	^ [ Character codePoint: 16rFFFF.
		16rFFFF ]
			on: Error
			do: [ :error  | 16rFF ]
]

{ #category : #accessing }
WCUrlEncoder >> nextPut: aCharacter [ 
	| value encoded |
	value := aCharacter greaseInteger.
	encoded := table at: value + 1.
"	encoded notNil ifTrue: [ 1halt. ]."
	"Issue 482: use #notNil because it is faster than #isString because it is not actually sent"
	encoded notNil 
		ifTrue: [ stream nextPutAll: encoded ]
		ifFalse: [ stream nextPut: aCharacter asCharacter ]
]

{ #category : #accessing }
WCUrlEncoder >> nextPutAll: aString [ 
	"uses #to:do: for speed reasons (on Pharo)
	this is not premature optimization, this is a hotspot method method
	and #to:do: shows measurable speed improvements for rendering seaside pages"
	1 to: aString size do: [ :index |
		self nextPut: (aString at: index) ]
]
