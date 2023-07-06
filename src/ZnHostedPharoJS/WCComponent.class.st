Class {
	#name : #WCComponent,
	#superclass : #Object,
	#instVars : [
		'uuid',
		'onStart',
		'observer'
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
WCComponent >> getComponentRoot [

	^ document getElementById: uuid
]

{ #category : #rendering }
WCComponent >> getElementById: aSymbol [
	^ self getComponentRoot querySelector: '#', aSymbol
]

{ #category : #'instance creation' }
WCComponent >> initAtRuntime [
	<javascript:'return this.pj_initStartCallback()'>
]

{ #category : #'instance creation' }
WCComponent >> initStartCallback [

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
WCComponent >> renderComponentOn: html [

	html div
		id: (uuid := WCUUIDGeneratorWrapper next);
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
