Class {
	#name : 'WCOptionTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCOptionTag >> tag [
	^ 'option'
]

{ #category : 'accessing' }
WCOptionTag >> value: aString [
	self attributes at: 'value' put: aString
]
