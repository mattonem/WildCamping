Class {
	#name : #WCSVGTag,
	#superclass : #WCTagBrush,
	#category : #WildCampComponent
}

{ #category : #accessing }
WCSVGTag >> fill: aString [ 
	self attributes 
		at: 'fill'
		put: aString
]

{ #category : #'as yet unclassified' }
WCSVGTag >> fillCurrentColor [
	self attributes 
		at: 'fill'
		put: 'currentColor'
]

{ #category : #attributes }
WCSVGTag >> height: anInteger [ 
	self attributes 
		at: 'height'
		put: anInteger
]

{ #category : #accessing }
WCSVGTag >> tag [
	^ 'svg'
]

{ #category : #'project state' }
WCSVGTag >> viewBox: aString [ 
	self attributes 
		at: 'viewBox'
		put: aString
]

{ #category : #accessing }
WCSVGTag >> width: anInteger [

	self attributes at: 'width' put: anInteger
]
