Class {
	#name : 'WCAutoFormDemo',
	#superclass : 'PjFileBasedWebApp',
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'description' }
WCAutoFormDemo class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , {WCAutoForm. WCEFMockModel} 
]

{ #category : 'description' }
WCAutoFormDemo class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : 'description' }
WCAutoFormDemo class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : 'description' }
WCAutoFormDemo class >> generateHtmlUsing: html [

	<pharoJsSkip>
	html div
		class: 'container';
		with: [ :cont |
			cont div
				class: 'card';
				with: [ :card |
					self
						addComponent: (WCAutoForm new
								 model: WCEFMockModel new;
								 on: html)
						named: #autoForm ] ]
]

{ #category : 'description' }
WCAutoFormDemo class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root language: 'en'.
	root stylesheet
		url:
			'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root	stylesheet url:
			'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css'
]

{ #category : 'initialize-release' }
WCAutoFormDemo >> initialize [

	super initialize.
]

{ #category : 'initialize-release' }
WCAutoFormDemo >> start [

	super start.
	self initializeComponentHolder.
	
]
