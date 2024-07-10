Class {
	#name : 'WCTextAreaTag',
	#superclass : 'WCFormInputTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCTextAreaTag >> isClosed [

	^ false
]

{ #category : 'accessing' }
WCTextAreaTag >> rows: anInteger [
	"This attribute specifies the number of visible text lines. If more are entered, the widget scrolls."

	self attributes at: 'rows' put: anInteger
]

{ #category : 'accessing' }
WCTextAreaTag >> tag [

	^ 'textArea'
]

{ #category : 'accessing' }
WCTextAreaTag >> type [

	^ nil
]
