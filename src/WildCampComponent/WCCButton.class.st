Class {
	#name : #WCCButton,
	#superclass : #WCComponent,
	#instVars : [
		'label',
		'onClick'
	],
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCButton >> initialize [ 
	label := 'Default button label'
]

{ #category : #accessing }
WCCButton >> label [

	^ label
]

{ #category : #accessing }
WCCButton >> label: anObject [

	label := anObject.
		self
		getElementById: 'button'
		whenReadyDo: [ :el | el innerHTML: anObject ]
]

{ #category : #accessing }
WCCButton >> onClick: aBlock [

	^ (self getElementById: 'button')
		  addEventListener: #click
		  block: aBlock
]

{ #category : #rendering }
WCCButton >> renderHtmlOn: html [

	html button
		class: 'btn btn-primary';
		id: 'button';
		with: label
]
