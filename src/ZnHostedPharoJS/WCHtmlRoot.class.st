Class {
	#name : #WCHtmlRoot,
	#superclass : #WCHtmlObject,
	#instVars : [
		'headElements',
		'docType',
		'title',
		'htmlAttrs',
		'headAttrs',
		'bodyAttrs',
		'styles',
		'scripts'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #adding }
WCHtmlRoot >> add: aHtmlElement [
	"Add a HTML head element to the receiver."

	^ headElements add: aHtmlElement
]

{ #category : #doctype }
WCHtmlRoot >> beHtml5 [
	self docType: '<!DOCTYPE html>'
]

{ #category : #writing }
WCHtmlRoot >> closeOn: aDocument [
	self writeFootOn: aDocument
]

{ #category : #doctype }
WCHtmlRoot >> docType: aString [
	"Set the document-type of the receiver. The table at http://www.w3.org/TR/2002/NOTE-xhtml-media-types-20020430/ summarizes the recommendation to content authors for labeling their XHTML documents:

Media type				XHTML 1.0 (HTML compatible)	XHTML 1.0 (other)	XHTML Basic / 1.1	XHTML+MathML
text/html				MAY							SHOULD NOT			SHOULD NOT			SHOULD NOT
application/xhtml+xml	SHOULD							SHOULD				SHOULD				SHOULD
application/xml			MAY							MAY				MAY				MAY
text/xml					MAY							MAY				MAY				MAY"

	docType := aString
]

{ #category : #accessing }
WCHtmlRoot >> htmlAttributes [
	^ htmlAttrs ifNil: [ htmlAttrs := WCHtmlAttributes new ]
]

{ #category : #accessing }
WCHtmlRoot >> initialize [
	super initialize.
	headElements := OrderedCollection new.
	title := docType := String new
]

{ #category : #accessing }
WCHtmlRoot >> javascript [
	^ self script beJavascript; yourself
]

{ #category : #accessing }
WCHtmlRoot >> language: aString [
	self htmlAttributes at: 'lang' put: aString
]

{ #category : #accessing }
WCHtmlRoot >> link [
	^ self add: (WCLinkElement root: self)
]

{ #category : #combining }
WCHtmlRoot >> meta [
	^ self add: (WCMetaElement root: self)
]

{ #category : #'instance creation' }
WCHtmlRoot >> openOn: aDocument [
	self writeHeadOn: aDocument
]

{ #category : #accessing }
WCHtmlRoot >> script [
	^ self add: (WCScriptElement root: self)
]

{ #category : #elements }
WCHtmlRoot >> stylesheet [
	^ self link beStylesheet; beCss; yourself
]

{ #category : #accessing }
WCHtmlRoot >> title: aString [
	title := aString
]

{ #category : #writing }
WCHtmlRoot >> writeElementsOn: aDocument [
	aDocument openTag: 'title'; nextPutAll: title; closeTag: 'title'.
	headElements do: [ :each | aDocument print: each ]
]

{ #category : #writing }
WCHtmlRoot >> writeFootOn: aDocument [
	aDocument closeTag: 'body'.
	aDocument closeTag: 'html'
]

{ #category : #writing }
WCHtmlRoot >> writeHeadOn: aDocument [
	aDocument nextPutAll: docType.
	aDocument openTag: 'html' attributes: htmlAttrs.
	aDocument openTag: 'head' attributes: headAttrs.
	self writeElementsOn: aDocument.
	self writeStylesOn: aDocument.
	self writeScriptsOn: aDocument.
	aDocument closeTag: 'head'.
	aDocument openTag: 'body' attributes: bodyAttrs
]

{ #category : #writing }
WCHtmlRoot >> writeScriptsOn: aDocument [
	scripts ifNil: [ ^ self ].
	scripts do: [ :each |
		aDocument print: ((WCScriptElement root: self)
			beJavascript;
			document: each;
			yourself) ]
]

{ #category : #writing }
WCHtmlRoot >> writeStylesOn: aDocument [
	styles ifNil: [ ^ self ].
	styles do: [ :each |
		aDocument print: ((WCLinkElement root: self)
			beStylesheet; beCss;
			document: each;
			yourself) ]
]
