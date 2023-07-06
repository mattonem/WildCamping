Class {
	#name : #CampingSiteQuality,
	#superclass : #Object,
	#category : #CampingWebApp
}

{ #category : #visiting }
CampingSiteQuality >> accept: aClass with: aWCHtmlCanvas [ 
	self subclassResponsibility .
]

{ #category : #accessing }
CampingSiteQuality >> categories [
	^ {  }
]
