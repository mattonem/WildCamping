Class {
	#name : 'WCLabelTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'instance creation' }
WCLabelTag >> for: aString [ 
	self attributes 
		at: 'for'
		put: aString
]

{ #category : 'accessing' }
WCLabelTag >> tag [
	^ 'label'
]
