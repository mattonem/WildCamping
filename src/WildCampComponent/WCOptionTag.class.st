Class {
	#name : 'WCOptionTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCOptionTag >> selected [
	self selected: true. 
]

{ #category : 'accessing' }
WCOptionTag >> selected: aBoolean [
	self attributes at: 'selected' put: aBoolean 
]

{ #category : 'accessing' }
WCOptionTag >> tag [
	^ 'option'
]

{ #category : 'accessing' }
WCOptionTag >> value: aString [
	self attributes at: 'value' put: aString
]
