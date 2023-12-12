Class {
	#name : #WCHelloWorldComponent,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#instVars : [
		'user',
		'comp'
	],
	#classVars : [
		'AngryGreetingParagraph',
		'GreetingParagraph'
	],
	#category : #'WildCampComponent-Examples'
}

{ #category : #generating }
WCHelloWorldComponent >> renderHtmlOn: html [
	html div
		class: 'container';
		with: [ :cont |
			cont div
				class: 'card';
				with: [ :card |
					card div
						class: 'card-header';
						with: 'Hello World !'.

					self addComponent: WCCHelloWorld new named: #hello on: html ].
			cont div
				class: 'card';
				with: [ :card |
					card div
						class: 'card-header';
						with: 'Multiple Counter'.
					card div
						class: 'card-body';
						with: 
					[
					self addComponent: WCCCounterMultiple new named: #counters on: html.
					 ]] ]
]

{ #category : #'initialize-release' }
WCHelloWorldComponent >> start [ 	
super start. 
self initializeComponentHolder.
]
