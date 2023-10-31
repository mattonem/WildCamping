Class {
	#name : #WCComponent,
	#superclass : #Object,
	#traits : 'PjTDomController',
	#classTraits : 'PjTDomController classTrait',
	#instVars : [
		'uuid',
		'onStart'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'as yet unclassified' }
WCComponent class >> for: anObject on: aWCHtmlCanvas named: aString [
	
	| inst |
	inst := anObject addComponent: (self on: aWCHtmlCanvas) named: aString.
	^ inst
]

{ #category : #'instance creation' }
WCComponent class >> on: aWCHtmlCanvas [

	^ self new
		  on: aWCHtmlCanvas;
		  yourself
]

{ #category : #rendering }
WCComponent >> componentWrapperClassName [
	^ 'WCComponentWrapper'
]

{ #category : #rendering }
WCComponent >> getComponentRoot [

	^ document getElementById: uuid
]

{ #category : #rendering }
WCComponent >> getElementById: aSymbol [

	| res |
	(self getComponentRoot querySelectorAll: '#' , aSymbol)
		detect: [ :el | (self parentWCOf: el) = self getComponentRoot ]
		ifFound: [ :el | res := el ].
	^ res
]

{ #category : #'instance creation' }
WCComponent >> initAtRuntime [
	<javascript:'return this.pj_initStartCallback()'>
]

{ #category : #'instance creation' }
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

{ #category : #'initialize-release' }
WCComponent >> initialize [
	super initialize.
]

{ #category : #'instance creation' }
WCComponent >> on: aWCHtmlCanvas [

	
	self initAtRuntime.
	self renderComponentOn: aWCHtmlCanvas.
]

{ #category : #'instance creation' }
WCComponent >> onStart [

	^ onStart ifNil: [ onStart := OrderedCollection new ]
]

{ #category : #'instance creation' }
WCComponent >> onStartDo: aBlock [
	self onStart add: aBlock
]

{ #category : #rendering }
WCComponent >> parentWCOf: anElement [

	anElement tagName = 'HTML' ifTrue: [ ^ anElement ].
	^ (((self cssClassesStringElement:anElement ) splitOn: ' ') includesAll:
		   { self componentWrapperClassName })
		  ifTrue: [ anElement ]
		  ifFalse: [ self parentWCOf: anElement parentElement ]
]

{ #category : #rendering }
WCComponent >> renderComponentOn: html [

	html div
		id: (uuid := WCUUIDGeneratorWrapper next);
		class: self componentWrapperClassName ;
		with: [ self renderHtmlOn: html ]
]

{ #category : #rendering }
WCComponent >> renderHtmlOn: html [
	self subclassResponsibility
]

{ #category : #'instance creation' }
WCComponent >> start [
	self onStart do: [ :aBlock | aBlock cull: self ]
]

{ #category : #accessing }
WCComponent >> uuid [
	^ uuid
]
