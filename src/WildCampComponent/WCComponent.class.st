Class {
	#name : 'WCComponent',
	#superclass : 'Object',
	#traits : 'PjTDomController',
	#classTraits : 'PjTDomController classTrait',
	#instVars : [
		'uuid',
		'onStart'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'as yet unclassified' }
WCComponent class >> for: anObject on: aWCHtmlCanvas named: aString [
	
	| inst |
	inst := anObject addComponent: (self on: aWCHtmlCanvas) named: aString.
	^ inst
]

{ #category : 'instance creation' }
WCComponent class >> on: aWCHtmlCanvas [

	^ self new
		  on: aWCHtmlCanvas;
		  yourself
]

{ #category : 'event init' }
WCComponent >> addComponent: aComp in: anHtmlElment [

	| frag |
	frag := document createElement: 'template'.
	frag innerHTML: (WCHtmlCanvas builder
			 fullDocument: false;
			 render: [ :html | aComp on: html ]).
		anHtmlElment 	appendChild: frag content.

]

{ #category : 'event init' }
WCComponent >> addComponentIn: anHtmlElment [

	| frag |
	frag := document createElement: 'template'.
	frag innerHTML: (WCHtmlCanvas builder
			 fullDocument: false;
			 render: [ :html | self on: html ]).
	anHtmlElment appendChild: frag content
]

{ #category : 'creating' }
WCComponent >> addEventListener: eventName block: block [	
	self getComponentRoot addEventListener: eventName block: block	 
]

{ #category : 'rendering' }
WCComponent >> componentWrapperClassName [
	^ 'WCComponentWrapper'
]

{ #category : 'accessing' }
WCComponent >> components [
	^ {  }
]

{ #category : 'rendering' }
WCComponent >> dispatchEvent: anEvent [
	self getComponentRoot dispatchEvent: anEvent
	
]

{ #category : 'rendering' }
WCComponent >> getComponentRoot [
	uuid ifNil: [ ^ nil ].
	^ document getElementById: uuid
]

{ #category : 'rendering' }
WCComponent >> getElementById: aSymbol [

self getComponentRoot ifNil: [ ^ nil ].
	^ (self getComponentRoot querySelectorAll: '#' , aSymbol)
		  detect: [ :el | (self parentWCOf: el) = self getComponentRoot ]
		  ifFound: [ :el | el ]
		  ifNone: [ nil ]
]

{ #category : 'accessing' }
WCComponent >> getElementById: aString whenReadyDo: aBlock [
	<javascript:'return this.pj_jsGetElementById_whenReadyDo_(aString, aBlock)'>
	
]

{ #category : 'instance creation' }
WCComponent >> initAtRuntime [
	<javascript:'return this.pj_initStartCallback()'>
]

{ #category : 'instance creation' }
WCComponent >> initStartCallback [

	| observer |
	self getComponentRoot ifNotNil: [ ^ self start ].
	observer := MutationObserver new: [ :aMutation |
		            self getComponentRoot ifNotNil: [
			            self start.
			            observer disconnect ] ].
	observer observe: document body with: {
			(#childList -> true).
			(#subtree -> true) } asJsObject
]

{ #category : 'initialize-release' }
WCComponent >> initialize [
	super initialize.
]

{ #category : 'accessing' }
WCComponent >> jsGetElementById: aString whenReadyDo: aBlock [

	^ (self getElementById: aString)
		  ifNotNil: [ :el | aBlock cull: el ]
		  ifNil: [
		  self onStartDo: [ aBlock cull: (self getElementById: aString) ] ]
]

{ #category : 'instance creation' }
WCComponent >> on: aWCHtmlCanvas [

	
	self initAtRuntime.
	self renderComponentOn: aWCHtmlCanvas.
]

{ #category : 'instance creation' }
WCComponent >> onStart [

	^ onStart ifNil: [ onStart := OrderedCollection new ]
]

{ #category : 'instance creation' }
WCComponent >> onStartDo: aBlock [
	self onStart add: aBlock
]

{ #category : 'rendering' }
WCComponent >> parentWCOf: anElement [

	anElement tagName = 'HTML' ifTrue: [ ^ anElement ].
	^ (((self cssClassesStringElement:anElement ) splitOn: ' ') includesAll:
		   { self componentWrapperClassName })
		  ifTrue: [ anElement ]
		  ifFalse: [ self parentWCOf: anElement parentElement ]
]

{ #category : 'accessing' }
WCComponent >> remove [

	self components do: [ :aComp | aComp remove ].
	self getComponentRoot remove.
]

{ #category : 'rendering' }
WCComponent >> renderComponentOn: html [

	html div
		id: (uuid := WCUUIDGeneratorWrapper next);
		class: self componentWrapperClassName;
		style: 'display: contents;';
		with: [ self renderHtmlOn: html ]
]

{ #category : 'rendering' }
WCComponent >> renderHtmlOn: html [
	self subclassResponsibility
]

{ #category : 'instance creation' }
WCComponent >> start [
	self onStart do: [ :aBlock | aBlock cull: self ]
]

{ #category : 'accessing' }
WCComponent >> uuid [
	^ uuid
]
