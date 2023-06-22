Class {
	#name : #WCContentElement,
	#superclass : #WCHtmlElement,
	#category : #ZnHostedPharoJS
}

{ #category : #testing }
WCContentElement >> encodeChildrenOn: aDocument [ 
	children isEmptyOrNil ifTrue: [ ^ self ].
	children do: [ :each | aDocument nextPutAll: each greaseString ]
]

{ #category : #testing }
WCContentElement >> isClosed [
	^ false
]
