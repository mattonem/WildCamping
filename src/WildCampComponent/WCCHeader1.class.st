Class {
	#name : #WCCHeader1,
	#superclass : #WCComponent,
	#instVars : [
		'content'
	],
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCHeader1 >> content: aString [

	content := aString.
	self
		getElementById: 'main'
		whenReadyDo: [ :el | el innerHTML: aString ]
]

{ #category : #rendering }
WCCHeader1 >> initialize [ 
	content := 'Default Title'
]

{ #category : #rendering }
WCCHeader1 >> renderHtmlOn: html [

	html heading
		level: 1;
		id: #main;
		with: content
]
