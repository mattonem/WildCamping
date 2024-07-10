Class {
	#name : 'WCComponentApp',
	#superclass : 'PjFileBasedWebApp',
	#classInstVars : [
		'component'
	],
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCComponentApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { self rootComponentClass }
]

{ #category : 'accessing' }
WCComponentApp class >> bridgeClientClass [

	<pharoJsSkip>
	^ PjZnHostedBrowserBridgeClient
]

{ #category : 'accessing' }
WCComponentApp class >> component [

	^ component ifNil: [
		  component := PhxJsonReader readFromString:
			                      self staticComponentSerialized ]
]

{ #category : 'accessing' }
WCComponentApp class >> exporterClass [

	<pharoJsSkip>
	^ PjFileExporterWithIndexHtml
]

{ #category : 'accessing' }
WCComponentApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	component := self rootComponentClass new on: html; yourself
]

{ #category : 'accessing' }
WCComponentApp class >> rootComponentClass [
self subclassResponsibility 
]

{ #category : 'accessing' }
WCComponentApp class >> staticComponentSerialized [

	<pharoJsSkip>
	self subclassResponsibility
	"subclasses should implement: 
	staticComponentSerialized

	<jsLiteralGenerator>
	^ component asPhxJsonString"
]

{ #category : 'as yet unclassified' }
WCComponentApp class >> staticFoldersToExpose [

	<pharoJsSkip>
	^ {  } asDictionary
]

{ #category : 'as yet unclassified' }
WCComponentApp >> component [

	^ self class component
]

{ #category : 'as yet unclassified' }
WCComponentApp >> initializeComponentHolder [

	self component initStartCallback
]

{ #category : 'as yet unclassified' }
WCComponentApp >> start [

	super start.
	self initializeComponentHolder.
]
