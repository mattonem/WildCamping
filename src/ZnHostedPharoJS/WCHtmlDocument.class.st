Class {
	#name : #WCHtmlDocument,
	#superclass : #Object,
	#instVars : [
		'stream',
		'root',
		'scriptGenerator',
		'xmlEncoder',
		'urlEncoder'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'instance creation' }
WCHtmlDocument class >> on: aStream [
	^ self basicNew initializeWithStream: aStream; yourself
]

{ #category : #'initialize-release' }
WCHtmlDocument >> close [
	"Close the receiving document."

	root isNil ifFalse: [ root closeOn: self ]
]

{ #category : #'private - html' }
WCHtmlDocument >> closeTag: aString [
	"Close the XML tag named aString."

	stream nextPutAll: '</'; nextPutAll: aString; nextPut: $>
]

{ #category : #printing }
WCHtmlDocument >> encodeOn: aDocument [ 
	aDocument print: self greaseString
]

{ #category : #initialization }
WCHtmlDocument >> initializeWithStream: aStream [

	self initialize.
	stream := aStream.
	xmlEncoder := WCXmlEncoder on: aStream.
	urlEncoder := WCUrlEncoder on: aStream
]

{ #category : #accessing }
WCHtmlDocument >> nextPut: aCharacter [
	stream nextPut: aCharacter
]

{ #category : #accessing }
WCHtmlDocument >> nextPutAll: aString [
	stream nextPutAll: aString
]

{ #category : #'instance creation' }
WCHtmlDocument >> open: aRoot [
	"Open the receiving document with aRoot."

	(root := aRoot) openOn: self
]

{ #category : #'private - html' }
WCHtmlDocument >> openTag: aString [
	"Open the XML tag named aString."

	self openTag: aString attributes: nil closed: false
]

{ #category : #'private - html' }
WCHtmlDocument >> openTag: aString attributes: anAttributes [
	"Open the XML tag named aString with the attribute dictionary anAttributes."

	self openTag: aString attributes: anAttributes closed: false
]

{ #category : #writing }
WCHtmlDocument >> openTag: aString attributes: anAttributes closed: aBoolean [

	"Open the XML tag named aString with the attribute dictionary anAttributes. Immediately close the tag if aBoolean is true."

	stream
		nextPut: $<;
		nextPutAll: aString.
	anAttributes ifNotNil: [ anAttributes encodeOn: self ].

	aBoolean ifTrue: [ stream nextPut: $/ ].
	stream nextPut: $>
]

{ #category : #printing }
WCHtmlDocument >> print: anObject [
	anObject encodeOn: self
]

{ #category : #accessing }
WCHtmlDocument >> urlEncoder [
	^ urlEncoder
]

{ #category : #accessing }
WCHtmlDocument >> xmlEncoder [
	"Answer an encoder for XML data."

	^ xmlEncoder
]
