Class {
	#name : #WCCParagraph,
	#superclass : #WCComponent,
	#instVars : [
		'content'
	],
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCParagraph >> content: aString [

	content := aString.
	self
		getElementById: 'main'
		whenReadyDo: [ :el | el innerHTML: aString ]
]

{ #category : #rendering }
WCCParagraph >> initialize [

	content := 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
]

{ #category : #rendering }
WCCParagraph >> renderHtmlOn: html [

	html paragraph
		id: #main;
		with: content
]

{ #category : #rendering }
WCCParagraph >> start [

	super start
]
