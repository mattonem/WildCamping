Class {
	#name : #CampsiteRootContainer,
	#superclass : #WCComponent,
	#category : #CampingWebApp
}

{ #category : #rendering }
CampsiteRootContainer >> content: aString [

	(self getElementById: 'main') innerHTML: aString
]

{ #category : #rendering }
CampsiteRootContainer >> renderHtmlOn: html [

	html div
		id: 'main';
		class: 'container';
		with: [  ]
]
