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
