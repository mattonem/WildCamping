Class {
	#name : 'WCHtmlCanvas',
	#superclass : 'Object',
	#instVars : [
		'currentBrush',
		'parentBrush',
		'document'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCHtmlCanvas class >> builder [
	^ (WCBuilder on: self)
			rootClass: WCHtmlRoot;
			documentClass: WCHtmlDocument;
			yourself
]

{ #category : 'delegation' }
WCHtmlCanvas class >> configureRenderContext: aWARenderContext [
	"Do nothing, subclasses might specify what to do, if needed."
]

{ #category : 'accessing' }
WCHtmlCanvas >> anchor [
	"Defines an anchor."

	^ self brush: WCAnchorTag new
]

{ #category : 'public' }
WCHtmlCanvas >> brush: aBrush [
	self flush.
	currentBrush := aBrush.
	aBrush setParent: parentBrush canvas: self.
	^ aBrush
]

{ #category : 'accessing - structure variables' }
WCHtmlCanvas >> button [
	^ self brush: WCButtonTag new
]

{ #category : 'accessing' }
WCHtmlCanvas >> checkbox [

	^ self brush: WCCheckboxInputTag new
]

{ #category : 'tags-styles' }
WCHtmlCanvas >> div [
	"Defines a section in a document."

	^ self tag: 'div'
]

{ #category : 'accessing' }
WCHtmlCanvas >> document [
	^ document
]

{ #category : 'instance creation' }
WCHtmlCanvas >> document: aWCHtmlDocument [ 
	document := aWCHtmlDocument 
]

{ #category : 'accessing' }
WCHtmlCanvas >> flush [
	currentBrush isNil
		ifTrue: [ ^ self ].
	currentBrush close.
	currentBrush := nil
]

{ #category : 'accessing' }
WCHtmlCanvas >> form [
	^ self brush: WCFormTag new
]

{ #category : 't - rotating' }
WCHtmlCanvas >> heading [
	"Defines header 1 to header 6."

	^ self brush: WCHeadingTag new
]

{ #category : 'as yet unclassified' }
WCHtmlCanvas >> idiomatic [
	"Defines a section in a document."
	^ self brush: WCIdiomaticTag new
]

{ #category : 'accessing' }
WCHtmlCanvas >> image [
	"Defines an image."

	^ self brush: WCImageTag new
]

{ #category : 'accessing' }
WCHtmlCanvas >> label [
	"Defines a label for a form control."

	^ self brush: WCLabelTag new
]

{ #category : 'tags-lists' }
WCHtmlCanvas >> listItem [
	"Defines a list item."

	^ self tag: 'li'
]

{ #category : 'private' }
WCHtmlCanvas >> nest: aBlock [
	parentBrush := currentBrush.
	currentBrush := nil.
	self render: aBlock.
	self flush.
	parentBrush := parentBrush parent
]

{ #category : 'accessing' }
WCHtmlCanvas >> paragraph [
	"Defines a paragraph."

	^ self tag: 'p'
]

{ #category : 'accessing' }
WCHtmlCanvas >> path [
	^ self brush: WCPathTag new
]

{ #category : 'tags-output' }
WCHtmlCanvas >> preformatted [
	"Defines preformatted text."

	^ self tag: 'pre'
]

{ #category : 'rendering' }
WCHtmlCanvas >> render: anObject [

	self flush.
	anObject renderOn: self
]

{ #category : 'tags' }
WCHtmlCanvas >> section [
	"The section element represents a generic document or application section. A section, in this context, is a thematic grouping of content, typically with a header, possibly with a footer."
	^ self tag: 'section'
]

{ #category : 'accessing' }
WCHtmlCanvas >> span [
	"Defines a section in a document."

	^ self tag: 'span'
]

{ #category : 'form-buttons' }
WCHtmlCanvas >> submitButton [
	^ self brush: WCSubmitButtonTag new
]

{ #category : 'as yet unclassified' }
WCHtmlCanvas >> svg [
	^ self brush: WCSVGTag new
]

{ #category : 'accessing' }
WCHtmlCanvas >> tag: aString [
	"Defines a generic tag with the name aString."

	^ self brush: (WCGenericTag tag: aString)
]

{ #category : 'accessing' }
WCHtmlCanvas >> text: anObject [

	"Emit anObject onto the target document."

	self flush.
	self document print: anObject
]

{ #category : 'accessing' }
WCHtmlCanvas >> textArea [

	^ self brush: WCTextAreaTag new
]

{ #category : 'accessing' }
WCHtmlCanvas >> textInput [
	^ self brush: WCTextInputTag new
]

{ #category : 'tags-lists' }
WCHtmlCanvas >> unorderedList [
	"Defines an unordered list."

	^ self brush: WCUnorderedListTag new
]
