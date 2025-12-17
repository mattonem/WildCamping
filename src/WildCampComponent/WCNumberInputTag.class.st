Class {
	#name : 'WCNumberInputTag',
	#superclass : 'WCTextInputTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'as yet unclassified' }
WCNumberInputTag >> max: aValue [
	self attributeAt: 'max' put: aValue asString
]

{ #category : 'as yet unclassified' }
WCNumberInputTag >> min: aValue [
	self attributeAt: 'min' put: aValue asString
]

{ #category : 'as yet unclassified' }
WCNumberInputTag >> step: aValue [
	self attributeAt: 'step' put: aValue asString
]

{ #category : 'as yet unclassified' }
WCNumberInputTag >> type [
	^ 'number'
]

{ #category : 'attributes' }
WCNumberInputTag >> value: aValue [
	self attributeAt: 'value' put: aValue asString
]
