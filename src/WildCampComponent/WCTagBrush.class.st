Class {
	#name : 'WCTagBrush',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'canvas',
		'attributes',
		'closed'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'private' }
WCTagBrush >> after [
	"This template method is called directly after rendering the content of the receiver."
]

{ #category : 'accessing' }
WCTagBrush >> attributeAt: aKey put: aValue [
	^ self attributes at: aKey put: aValue
]

{ #category : 'accessing' }
WCTagBrush >> attributes [
	^ attributes ifNil: [ attributes := WCHtmlAttributes new ]
]

{ #category : 'private' }
WCTagBrush >> before [
	"This template method is called directly before rendering the content of the receiver."
]

{ #category : 'instance creation' }
WCTagBrush >> class: aString [
	"This attribute assigns one or more class names to an element; the element may be said to belong to these classes. A class name may be shared by several element instances. Multiple classes might be added to one brush."

	self attributes addClass: aString
]

{ #category : 'initialize-release' }
WCTagBrush >> close [
	"Close and flush the receiver onto the canvas and its associated document."

	closed ifFalse: [ self with: nil ]
]

{ #category : 'private' }
WCTagBrush >> closeTag [
	"Close the receiving tag onto the document."

	self document closeTag: self tag
]

{ #category : 'accessing' }
WCTagBrush >> document [
	^ canvas document
]

{ #category : 'accessing' }
WCTagBrush >> hidden: aBoolean [

	self attributeAt: 'hidden' put: aBoolean
]

{ #category : 'accessing' }
WCTagBrush >> id: aString [
	"The id attribute assigns a identifier to an element. The id of an element must be unique within a document."

	self attributes at: 'id' put: aString
]

{ #category : 'accessing' }
WCTagBrush >> initialize [
	super initialize.
	closed := false
]

{ #category : 'testing' }
WCTagBrush >> isClosed [
	^ false
]

{ #category : 'private' }
WCTagBrush >> openTag [
	"Open the receiving and all associated attributes onto the document."

	self document openTag: self tag attributes: attributes closed: self isClosed
]

{ #category : 'accessing' }
WCTagBrush >> parent [
	^ parent
]

{ #category : 'initialization' }
WCTagBrush >> setParent: aBrush canvas: aCanvas [
	parent := aBrush.
	canvas := aCanvas
]

{ #category : 'accessing' }
WCTagBrush >> style: aString [
	"This attribute offers optional CSS style information. The attribute is deprecated and should be avoided in favor of an external stylesheet. Multiple styles might be added to one brush."

	self attributes addStyle: aString
]

{ #category : 'instance creation' }
WCTagBrush >> with: anObject [
	"Render anObject into the receiver. Make sure that you call #with: last in the cascade, as this method will serialize the tag onto the output document."

	self openTag.
	canvas nest: [
		self before.
		canvas render: anObject.
		self after ].
	closed := true.
	self isClosed
		ifFalse: [ self closeTag ]
]
