Class {
	#name : 'WCElementDescription',
	#superclass : 'Object',
	#instVars : [
		'getter',
		'setter',
		'label'
	],
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'accessing' }
WCElementDescription >> getter [

	^ getter
]

{ #category : 'accessing' }
WCElementDescription >> getter: anObject [

	getter := anObject
]

{ #category : 'accessing' }
WCElementDescription >> id [

	^ getter
]

{ #category : 'accessing' }
WCElementDescription >> label [
	^ label
]

{ #category : 'accessing' }
WCElementDescription >> label: aString [

	label := aString
]

{ #category : 'rendering' }
WCElementDescription >> renderDescriptionOn: aWCAutoForm [ 
	self subclassResponsibility 
]

{ #category : 'rendering' }
WCElementDescription >> renderDescriptionOn: aWCAutoForm with: aWCHtmlCanvas [ 
	self subclassResponsibility .
]

{ #category : 'accessing' }
WCElementDescription >> setter [

	^ setter
]

{ #category : 'accessing' }
WCElementDescription >> setter: anObject [

	setter := anObject
]
