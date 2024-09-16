Class {
	#name : 'WCEditableComponentsDemo',
	#superclass : 'PjFileBasedWebApp',
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'description' }
WCEditableComponentsDemo class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , {WCEditableTextInput} 
]

{ #category : 'description' }
WCEditableComponentsDemo class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : 'description' }
WCEditableComponentsDemo class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : 'description' }
WCEditableComponentsDemo class >> generateHtmlUsing: html [

	<pharoJsSkip>
	html div
		class: 'container';
		with: [ :cont |
			cont div
				class: 'card';
				with: [ :card |
					self
						addComponent: (WCEditableTextInput new on: html)
						named: #newCounter ] ]
]

{ #category : 'accessing' }
WCEditableComponentsDemo class >> staticComponentsSerialized [

	<jsLiteralGenerator>
	^ self _staticComponents asPhxJsonString
]

{ #category : 'description' }
WCEditableComponentsDemo class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root language: 'en'.
	root stylesheet
		url:
			'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root	stylesheet url:
			'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css'
]

{ #category : 'initialize-release' }
WCEditableComponentsDemo >> initialize [

	super initialize
]

{ #category : 'initialize-release' }
WCEditableComponentsDemo >> start [

	super start.
	self initializeComponentHolder
]
