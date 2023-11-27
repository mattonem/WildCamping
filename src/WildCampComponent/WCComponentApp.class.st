Class {
	#name : #WCComponentApp,
	#superclass : #PjFileBasedWebApp,
	#classInstVars : [
		'staticComponents'
	],
	#category : #WildCampComponent
}

{ #category : #accessing }
WCComponentApp class >> _resetComponents [

	<script>
	<pharoJsSkip> 
	^ staticComponents := Dictionary new
]

{ #category : #accessing }
WCComponentApp class >> _staticComponents [

	<pharoJsSkip>
	^ staticComponents ifNil: [ staticComponents := Dictionary new ] 
]

{ #category : #accessing }
WCComponentApp class >> addComponent: aWCCParagraph named: aString [

	<pharoJsSkip>
	^ self addStaticComponent: aWCCParagraph named: aString 
]

{ #category : #accessing }
WCComponentApp class >> addComponent: aWCCParagraph named: aString on: html [

	<pharoJsSkip>
	^ self
		  addStaticComponent: (aWCCParagraph
				   on: html; 
				   yourself)
		  named: aString
]

{ #category : #accessing }
WCComponentApp class >> addStaticComponent: aWCCParagraph named: aString [

	<pharoJsSkip>
	^ self _staticComponents at: aString put: aWCCParagraph 
]

{ #category : #accessing }
WCComponentApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , {
		  CSCreationForm }
]

{ #category : #accessing }
WCComponentApp class >> bridgeClientClass [

	<pharoJsSkip>
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #accessing }
WCComponentApp class >> components [

	^ self staticComponents
]

{ #category : #accessing }
WCComponentApp class >> exporterClass [

	<pharoJsSkip>
	^ PjFileExporterWithIndexHtml
]

{ #category : #accessing }
WCComponentApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	self addComponent: self rootComponentClass new named: #form on: html
]

{ #category : #accessing }
WCComponentApp class >> rootComponentClass [
self subclassResponsibility 
]

{ #category : #accessing }
WCComponentApp class >> staticComponents [

	^ staticComponents ifNil: [
		  staticComponents := PhxJsonReader readFromString:
			                      self staticComponentsSerialized ]
]

{ #category : #accessing }
WCComponentApp class >> staticComponentsSerialized [

	<pharoJsSkip>
	self subclassResponsibility.
	"subclasses should implement: 
	staticComponentsSerialized

	<jsLiteralGenerator>
	^ self _staticComponents asPhxJsonString"
]

{ #category : #'as yet unclassified' }
WCComponentApp >> components [
	^ self class components
]

{ #category : #'as yet unclassified' }
WCComponentApp >> initializeComponentHolder [

	self components do: [ :component | component initStartCallback ]
]

{ #category : #'as yet unclassified' }
WCComponentApp >> start [

	super start.
	self initializeComponentHolder.
]
