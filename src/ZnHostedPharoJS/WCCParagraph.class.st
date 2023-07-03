Class {
	#name : #WCCParagraph,
	#superclass : #WCComponent,
	#pools : [
		'PjDomGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #rendering }
WCCParagraph >> content: aString [

	(self getElementById: 'main') innerHTML: aString
]

{ #category : #rendering }
WCCParagraph >> renderHtmlOn: html [

	html paragraph
		id: #main;
		with: ''
]