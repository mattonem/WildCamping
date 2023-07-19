Class {
	#name : #WCAnchorTag,
	#superclass : #WCTagBrush,
	#instVars : [
		'url'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #attributes }
WCAnchorTag >> charset: aString [
	"This attribute specifies the character encoding of the resource designated by the link."
	
	self attributes at: 'charset' put: aString
]

{ #category : #url }
WCAnchorTag >> extraParameters: aString [
	self url addField: aString
]

{ #category : #url }
WCAnchorTag >> extraPath: aString [
	self url addToPath: aString
]

{ #category : #accessing }
WCAnchorTag >> name: aString [
	"This attribute names the current anchor so that it may be the destination of another link. The value of this attribute must be a unique anchor name. The scope of this name is the current document. Note that this attribute shares the same name space as the id attribute."

	self attributes at: 'name' put: aString
]

{ #category : #attributes }
WCAnchorTag >> relationship: aString [
	"This attribute describes the relationship from the current document to the anchor specified by the href attribute. The value of this attribute is a space-separated list of link types."
	
	self attributes at: 'rel' append: aString
]

{ #category : #attributes }
WCAnchorTag >> reverse: aString [
	"This attribute is used to describe a reverse link from the anchor specified by the href attribute to the current document. The value of this attribute is a space-separated list of link types."
	
	self attributes at: 'rev' append: aString
]

{ #category : #accessing }
WCAnchorTag >> tag [
	^ 'a'
]

{ #category : #accessing }
WCAnchorTag >> target: aString [ 
	"This attribute specifies the name of a frame where a document is to be opened."
	
	self attributes at: 'target' put: aString
]

{ #category : #target }
WCAnchorTag >> targetBlank [
	"Load the URL into a new browsing context. This is usually a tab, but users can configure browsers to use new windows instead.
	
	WARNING:
	Use with parcimonie. It goes against web development best practices to force the user to open the link in a new tab. Usually your should let the user decide how he wants to open a link.
	
	Linking to another page using target=""_blank"" will run the new page on the same process as your page. If the new page is executing expensive JS, your page's performance may suffer. To avoid this use rel=""noopener""."

	self target: '_blank'
]

{ #category : #target }
WCAnchorTag >> targetParent [
	"Load the URL into the parent browsing context of the current one. If there is no parent, this behaves the same way as _self."

	self target: '_parent'
]

{ #category : #target }
WCAnchorTag >> targetSelf [
	"Load the URL into the same browsing context as the current one. This is the default behavior."

	self target: '_self'
]

{ #category : #target }
WCAnchorTag >> targetTop [
	" Load the URL into the top-level browsing context (that is, the «highest» browsing context that is an ancestor of the current one, and has no parent). If there is no parent, this behaves the same way as _self."

	self target: '_top'
]

{ #category : #'accessing - structure variables' }
WCAnchorTag >> type: aString [
	"This attribute gives an advisory hint as to the content type of the content available at the link target address. It allows user agents to opt to use a fallback mechanism rather than fetch the content if they are advised that they will get content in a content type they do not support."
	
	self attributes at: 'type' put: aString
]

{ #category : #accessing }
WCAnchorTag >> url [
	^ url ifNil: [ url := WCUrl new ]
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
