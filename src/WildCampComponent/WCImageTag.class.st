Class {
	#name : #WCImageTag,
	#superclass : #WCTagBrush,
	#category : #WildCampComponent
}

{ #category : #attributes }
WCImageTag >> altText: aString [
	"The alt attribute provides a short description of the image."

	self attributes at: 'alt' put: aString
]

{ #category : #accessing }
WCImageTag >> tag [

	^ 'img'
]

{ #category : #attributes }
WCImageTag >> url: aString [

	self attributes at: 'src' put: aString
]
