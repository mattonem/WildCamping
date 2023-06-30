Class {
	#name : #WCLabelTag,
	#superclass : #WCTagBrush,
	#category : #ZnHostedPharoJS
}

{ #category : #'instance creation' }
WCLabelTag >> for: aString [ 
	self attributes 
		at: 'for'
		put: aString
]

{ #category : #accessing }
WCLabelTag >> tag [
	^ 'label'
]
