Class {
	#name : #WCComponent,
	#superclass : #Object,
	#instVars : [
		'uuid'
	],
	#pools : [
		'PjDomGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'as yet unclassified' }
WCComponent class >> for: anObject on: aWCHtmlCanvas named: aString [
	^ anObject addComponent: (self on: aWCHtmlCanvas) named: aString
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

{ #category : #'initialize-release' }
WCComponent >> initialize [
	super initialize.
]

{ #category : #'instance creation' }
WCComponent >> on: aWCHtmlCanvas [ 
	self renderComponentOn: aWCHtmlCanvas 
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
]