Class {
	#name : 'WCStingDescription',
	#superclass : 'WCElementDescription',
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'rendering' }
WCStingDescription >> renderDescriptionOn: aWCAutoForm [ 
	self shouldBeImplemented.
]

{ #category : 'rendering' }
WCStingDescription >> renderDescriptionOn: aWCAutoForm with: aWCHtmlCanvas [ 
	aWCAutoForm renderString: self with: aWCHtmlCanvas 
]
