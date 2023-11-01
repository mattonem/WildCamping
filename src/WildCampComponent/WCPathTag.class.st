Class {
	#name : #WCPathTag,
	#superclass : #WCTagBrush,
	#category : #WildCampComponent
}

{ #category : #'accessing - structure variables' }
WCPathTag >> d: aString [ 
	self attributes 
		at: 'd'
		put: aString
]

{ #category : #accessing }
WCPathTag >> tag [
	^ 'path'
]
