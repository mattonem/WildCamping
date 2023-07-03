Class {
	#name : #WCHtmlCanvas,
	#superclass : #Object,
	#instVars : [
		'currentBrush',
		'parentBrush',
		'document'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCHtmlCanvas class >> builder [
	^ (WCBuilder on: self)
			rootClass: WCHtmlRoot;
			documentClass: WCHtmlDocument;
			yourself
]

{ #category : #delegation }
WCHtmlCanvas class >> configureRenderContext: aWARenderContext [
	"Do nothing, subclasses might specify what to do, if needed."
]

{ #category : #public }
WCHtmlCanvas >> brush: aBrush [
	self flush.
	currentBrush := aBrush.
	aBrush setParent: parentBrush canvas: self.
	^ aBrush
]

{ #category : #'accessing - structure variables' }
WCHtmlCanvas >> button [
	^ self brush: WCButtonTag new
]

{ #category : #'tags-styles' }
WCHtmlCanvas >> div [
	"Defines a section in a document."

	^ self tag: 'div'
]

{ #category : #accessing }
WCHtmlCanvas >> document [
	^ document
]

{ #category : #'instance creation' }
WCHtmlCanvas >> document: aWCHtmlDocument [ 
	document := aWCHtmlDocument 
]

{ #category : #accessing }
WCHtmlCanvas >> flush [
	currentBrush isNil
		ifTrue: [ ^ self ].
	currentBrush close.
	currentBrush := nil
]

{ #category : #accessing }
WCHtmlCanvas >> label [
	"Defines a label for a form control."

	^ self brush: WCLabelTag new
]

{ #category : #'tags-lists' }
WCHtmlCanvas >> listItem [
	"Defines a list item."

	^ self tag: 'li'
]

{ #category : #private }
WCHtmlCanvas >> nest: aBlock [
	parentBrush := currentBrush.
	currentBrush := nil.
	self render: aBlock.
	self flush.
	parentBrush := parentBrush parent
]

{ #category : #accessing }
WCHtmlCanvas >> paragraph [
	"Defines a paragraph."

	^ self tag: 'p'
]

{ #category : #'tags-output' }
WCHtmlCanvas >> preformatted [
	"Defines preformatted text."

	^ self tag: 'pre'
]

{ #category : #rendering }
WCHtmlCanvas >> render: anObject [

	self flush.
	anObject renderOn: self
]

{ #category : #accessing }
WCHtmlCanvas >> span [
	"Defines a section in a document."

	^ self tag: 'span'
]

{ #category : #accessing }
WCHtmlCanvas >> tag: aString [
	"Defines a generic tag with the name aString."

	^ self brush: (WCGenericTag tag: aString)
]

{ #category : #accessing }
WCHtmlCanvas >> text: anObject [

	"Emit anObject onto the target document."

	self flush.
	self document print: anObject
]

{ #category : #accessing }
WCHtmlCanvas >> textInput [
	^ self brush: WCTextInputTag new
]

{ #category : #'tags-lists' }
WCHtmlCanvas >> unorderedList [
	"Defines an unordered list."

	^ self brush: WCUnorderedListTag new
]
