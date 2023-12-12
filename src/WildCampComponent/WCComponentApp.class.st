Class {
	#name : #WCComponentApp,
	#superclass : #PjFileBasedWebApp,
	#classInstVars : [
		'#component => JavascriptSerializedInstanceVariableSlot'
	],
	#category : #WildCampComponent
}

{ #category : #accessing }
WCComponentApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { self rootComponentClass }
]

{ #category : #accessing }
WCComponentApp class >> bridgeClientClass [

	<pharoJsSkip>
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #accessing }
WCComponentApp class >> component [

	^ component 
]

{ #category : #accessing }
WCComponentApp class >> exporterClass [

	<pharoJsSkip>
	^ PjFileExporterWithIndexHtml
]

{ #category : #accessing }
WCComponentApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	component := self rootComponentClass new on: html; yourself
]

{ #category : #accessing }
WCComponentApp class >> rootComponentClass [
self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
WCComponentApp class >> staticFoldersToExpose [

	<pharoJsSkip>
	^ {  } asDictionary
]

{ #category : #'as yet unclassified' }
WCComponentApp >> component [

	^ self class component
]

{ #category : #'as yet unclassified' }
WCComponentApp >> initializeComponentHolder [

	self component initStartCallback
]

{ #category : #'as yet unclassified' }
WCComponentApp >> start [

	super start.
	self initializeComponentHolder.
]
