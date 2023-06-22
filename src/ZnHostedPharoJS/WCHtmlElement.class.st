Class {
	#name : #WCHtmlElement,
	#superclass : #Object,
	#instVars : [
		'children',
		'attributes',
		'root'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'instance creation' }
WCHtmlElement class >> root: aRoot [
	^ self basicNew initializeWithRoot: aRoot; yourself
]

{ #category : #adding }
WCHtmlElement >> add: anElement [
	children ifNil: [ children := OrderedCollection new ].
	children add: anElement
]

{ #category : #accessing }
WCHtmlElement >> attributeAt: aString put: anObject [
	^ self attributes at: aString put: anObject
]

{ #category : #accessing }
WCHtmlElement >> attributes [
	^ attributes ifNil: [ attributes := WCHtmlAttributes new ]
]

{ #category : #printing }
WCHtmlElement >> encodeAfterOn: aDocument [
	aDocument closeTag: self tag
]

{ #category : #printing }
WCHtmlElement >> encodeBeforeOn: aDocument [
	aDocument openTag: self tag attributes: attributes closed: self isClosed
]

{ #category : #accessing }
WCHtmlElement >> encodeOn: aDocument [
	self encodeBeforeOn: aDocument.
	self isClosed ifTrue: [ ^ self ].
	self encodeChildrenOn: aDocument.
	self encodeAfterOn: aDocument
]

{ #category : #initialization }
WCHtmlElement >> initializeWithRoot: aRoot [
	self initialize.
	root := aRoot
]

{ #category : #testing }
WCHtmlElement >> isClosed [
	^ true
]
