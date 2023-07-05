Class {
	#name : #WCCHeader1,
	#superclass : #WCComponent,
	#category : #ZnHostedPharoJS
}

{ #category : #rendering }
WCCHeader1 >> content: aString [

	(self getElementById: 'main') innerHTML: aString
]

{ #category : #rendering }
WCCHeader1 >> renderHtmlOn: html [

	html heading
		level: 1;
		id: #main;
		with: ''
]
