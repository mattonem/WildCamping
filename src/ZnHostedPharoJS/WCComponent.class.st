Class {
	#name : #WCComponent,
	#superclass : #Object,
	#traits : 'ComponentHolder',
	#classTraits : 'ComponentHolder classTrait',
	#instVars : [
		'uuid'
	],
	#pools : [
		'PjDomGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #'as yet unclassified' }
WCComponent class >> for: aClass on: aWCHtmlCanvas named: aString [
	<pharoJsSkip>
	^ aClass addStaticComponent: (self on: aWCHtmlCanvas) named: aString
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
