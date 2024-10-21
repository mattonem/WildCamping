Class {
	#name : 'WCRangeInputTag',
	#superclass : 'WCFormInputTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCRangeInputTag >> max: anInteger [ 
	self attributeAt: 'max' put: anInteger
]

{ #category : 'accessing' }
WCRangeInputTag >> min: anInteger [ 
	self attributeAt: 'min' put: anInteger
]

{ #category : 'accessing' }
WCRangeInputTag >> type [
	^ 'range'
]
