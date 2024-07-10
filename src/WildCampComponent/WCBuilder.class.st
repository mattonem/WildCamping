Class {
	#name : 'WCBuilder',
	#superclass : 'Object',
	#instVars : [
		'rendererClass',
		'rootClass',
		'documentClass',
		'fullDocument',
		'rootBlock'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'instance creation' }
WCBuilder class >> on: aRendererClass [
	^ self new
		rendererClass: aRendererClass;
		yourself
]

{ #category : 'private' }
WCBuilder >> closeDocument: aDocument [
	self fullDocument 
		ifTrue: [ aDocument close ]
		ifFalse: [ 
			"hack to make it work"
			(aDocument isKindOf: WCHtmlDocument)
				ifTrue: [ aDocument close ] ]
]

{ #category : 'accessing' }
WCBuilder >> documentClass [
	^ documentClass
]

{ #category : 'accessing' }
WCBuilder >> documentClass: aDocumentClass [
	documentClass := aDocumentClass
]

{ #category : 'accessing' }
WCBuilder >> fullDocument [
	^ fullDocument
]

{ #category : 'accessing' }
WCBuilder >> fullDocument: aBoolean [
	fullDocument := aBoolean
]

{ #category : 'accessing' }
WCBuilder >> initialize [ 
	fullDocument := false
]

{ #category : 'as yet unclassified' }
WCBuilder >> openDocument: aDocument [
	| documentRoot |
	self fullDocument ifFalse: [ ^ self ].
	documentRoot := self rootClass new.
	self rootBlock value: documentRoot.
	aDocument open: documentRoot
]

{ #category : 'rendering' }
WCBuilder >> render: anObject [
	^ String streamContents: [ :stream |
		self
			render: anObject
			on: stream ]
]

{ #category : 'rendering' }
WCBuilder >> render: anObject on: aStream [

	"Render anObject and return the contents of the resulting Document as a String.
	anObject must understand #renderOn:. Commonly anObject will be a one-argument
	block, which will be evaluated with the appropriate renderer."
	| document renderer |
	document := self documentClass on: aStream.

	self openDocument: document.
	renderer := self rendererClass new
		            document: document;
		            yourself.

	renderer
		render: anObject;
		flush.
	self closeDocument: document
]

{ #category : 'accessing' }
WCBuilder >> rendererClass [
	^ rendererClass
]

{ #category : 'accessing' }
WCBuilder >> rendererClass: aRendererClass [ 
	rendererClass := aRendererClass
]

{ #category : 'accessing' }
WCBuilder >> rootBlock [
	^ rootBlock ifNil: [ rootBlock := [ :root | ] ]
]

{ #category : 'accessing' }
WCBuilder >> rootBlock: anObject [
	rootBlock := anObject
]

{ #category : 'accessing' }
WCBuilder >> rootClass [
	^ rootClass ifNil: [ rootClass := WCHtmlRoot ]
]

{ #category : 'accessing' }
WCBuilder >> rootClass: aRootClass [
	rootClass := aRootClass
]
