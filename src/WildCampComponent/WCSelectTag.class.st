Class {
	#name : 'WCSelectTag',
	#superclass : 'WCCollectionTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCSelectTag >> disabled [
	self disabled: true
]

{ #category : 'accessing' }
WCSelectTag >> disabled: aBoolean [
	"The disabled attribute is a boolean attribute that, if present, indicates that the command is not available in the current state."

	self attributeAt: 'disabled' put: aBoolean
]

{ #category : 'accessing' }
WCSelectTag >> multiple [
	self multiple: true
]

{ #category : 'accessing' }
WCSelectTag >> multiple: aBoolean [
	"The disabled attribute is a boolean attribute that, if present, indicates that the command is not available in the current state."

	self attributeAt: 'multiple' put: aBoolean
]

{ #category : 'accessing' }
WCSelectTag >> tag [
	^ 'select'
]
