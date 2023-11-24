Class {
	#name : #CampingSiteAttributes,
	#superclass : #Object,
	#category : #CampingWebApp
}

{ #category : #visiting }
CampingSiteAttributes >> accept: aClass with: aWCHtmlCanvas [ 
	self subclassResponsibility .
]

{ #category : #accessing }
CampingSiteAttributes >> categories [
	^ {  }
]
