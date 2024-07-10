Class {
	#name : 'WCUrlEncoder',
	#superclass : 'WCEncoder',
	#classVars : [
		'table'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'instance creation' }
WCUrlEncoder class >> codePoint: anInteger [ 
	<pharoJsSkip>
	^ (String value: anInteger) first
]

{ #category : 'private' }
WCUrlEncoder class >> digitFor: digit [
	<pharoJsSkip>
	^ '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at: digit + 1
]

{ #category : 'private' }
WCUrlEncoder class >> encode: aCharacter on: aStream [ 
	<pharoJsSkip>
	('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~' includes: aCharacter) ifTrue: [ ^ aStream nextPut: aCharacter ].
	aStream nextPut: $%.
	self print: aCharacter charCode on: aStream
]

{ #category : 'initialization' }
WCUrlEncoder class >> initialize [

	<javascript: 'this.pj_initializeFromSerializedTable()'>
	self initializeTable
]

{ #category : 'initialization' }
WCUrlEncoder class >> initializeFromSerializedTable [
	<javascript: 'return this.table = this.pj_serializedTable()'>
	^ table := nil
]

{ #category : 'initialization' }
WCUrlEncoder class >> initializeTable [
	"Initializes the encoding table."
	<pharoJsSkip>
	|  characterLimit |
	characterLimit := self maximumCharacterValue.
	"character values at zero so we need to add 1"
	table := Array new: characterLimit + 1.
	table at: 1 put: '%00'.
	1 to: characterLimit do: [ :index | 
		| character value string|
		character := self codePoint: index.
		string := String new: 6 streamContents: [ :stream | self encode: character on: stream ].
		"Smalltalk indices are one based but character values start at 0"
		value := string = character asString
			ifTrue: [ nil ]
			ifFalse: [ string ].
		table at: index + 1 put: value ]
]

{ #category : 'initialization' }
WCUrlEncoder class >> maximumCharacterValue [
	"String to byte encoding has already happened in the server."

	<pharoJsSkip>
	^ 16rFF
]

{ #category : 'private' }
WCUrlEncoder class >> print: aNumber on: aStream [
	<pharoJsSkip>
	aStream << (self  printString: aNumber base: 16 nDigits: 2)
]

{ #category : 'private' }
WCUrlEncoder class >> printString: anInteger base: b nDigits: n [
	"Return a string representation of this number in base b with n digits (left padded with 0).
	Should be invoked with: 0 <= self < (b raisedToInteger: n)."
	<pharoJsSkip>
	| integer next |
	anInteger ifNil: [ ^ '' ].

	integer := anInteger.
	^ (String new: n streamContents: [ :stream |
		   n to: 1 by: -1 do: [ :i |
			   next := integer // b.
			   stream nextPut: (self digitFor: integer - (next * b)).
			   integer := next ] ]) reversed
]

{ #category : 'initialization' }
WCUrlEncoder class >> serializedTable [
	<jsLiteralGenerator>
	^ table 
]

{ #category : 'accessing' }
WCUrlEncoder >> maximumCharacterValue [
	"find the maximum value of a character that we can instantiate, for Squeak 3.7 this is 255"
	^ [ self class codePoint: 16rFFFF.
		16rFFFF ]
			on: Error
			do: [ :error  | 16rFF ]
]

{ #category : 'accessing' }
WCUrlEncoder >> nextPut: aCharacter [ 
	| value encoded |
	value := aCharacter charCode.
	encoded := table at: value + 1.
"	encoded notNil ifTrue: [ 1halt. ]."
	"Issue 482: use #notNil because it is faster than #isString because it is not actually sent"
	encoded notNil 
		ifTrue: [ stream nextPutAll: encoded ]
		ifFalse: [ stream nextPut: aCharacter asCharacter ]
]

{ #category : 'accessing' }
WCUrlEncoder >> nextPutAll: aString [ 
	"uses #to:do: for speed reasons (on Pharo)
	this is not premature optimization, this is a hotspot method method
	and #to:do: shows measurable speed improvements for rendering seaside pages"
	1 to: aString size do: [ :index |
		self nextPut: (aString at: index) ]
]
