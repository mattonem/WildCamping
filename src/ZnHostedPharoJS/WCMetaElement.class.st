Class {
	#name : #WCMetaElement,
	#superclass : #WCHtmlElement,
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCMetaElement >> language: aString [
	self attributeAt: 'lang' put: aString
]

{ #category : #accessing }
WCMetaElement >> tag [
	^ 'meta'
]
