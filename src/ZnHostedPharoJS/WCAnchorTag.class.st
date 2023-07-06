Class {
	#name : #WCAnchorTag,
	#superclass : #WCTagBrush,
	#instVars : [
		'url'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCAnchorTag >> tag [
	^ 'a'
]

{ #category : #attributes }
WCAnchorTag >> url: aUrlOrString [
	url := aUrlOrString
]

{ #category : #attributes }
WCAnchorTag >> with: aBlock [
	url isNil
		ifFalse: [ self attributes at: 'href' put: url ].
	super with: aBlock
]
