Class {
	#name : #WCLinkElement,
	#superclass : #WCContentElement,
	#category : #WildCampComponent
}

{ #category : #type }
WCLinkElement >> beCss [
	self type: WCMimeType textCss
]

{ #category : #relationship }
WCLinkElement >> beStylesheet [
	"Imports a stylesheet."
	self relationship: 'stylesheet'
]

{ #category : #attributes }
WCLinkElement >> isClosed [
	^ children isEmptyOrNil
]

{ #category : #attributes }
WCLinkElement >> relationship: aString [
	"This attribute describes the relationship from the current document to the anchor specified by the href attribute. The value of this attribute is a space-separated list of link types."
	
	self attributes at: 'rel' append: aString
]

{ #category : #accessing }
WCLinkElement >> tag [
	^ children isEmptyOrNil
		ifTrue: [ 'link' ]
		ifFalse: [ 'style' ]
]

{ #category : #'accessing - structure variables' }
WCLinkElement >> type: aMimeTypeOrString [
	self attributeAt: 'type' put: aMimeTypeOrString
]

{ #category : #attributes }
WCLinkElement >> url: aString [
	self attributeAt: 'href' put: aString
]
