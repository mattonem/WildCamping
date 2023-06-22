Class {
	#name : #WCScriptElement,
	#superclass : #WCContentElement,
	#category : #ZnHostedPharoJS
}

{ #category : #types }
WCScriptElement >> beJavascript [
	self type: WCMimeType textJavascript
]

{ #category : #accessing }
WCScriptElement >> tag [
	^ 'script'
]

{ #category : #'accessing - structure variables' }
WCScriptElement >> type: aString [ 
	"A valid MIME type that designates a styling language.
	A string that identifies a valid MIME media type as defined in [RFC 2046]."
	
	self attributes at: 'type' put: aString
]

{ #category : #attributes }
WCScriptElement >> url: aString [
	self attributeAt: 'src' put: aString
]
