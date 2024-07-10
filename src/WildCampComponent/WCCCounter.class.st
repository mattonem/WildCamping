Class {
	#name : 'WCCCounter',
	#superclass : 'WCComponent',
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#instVars : [
		'counter'
	],
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'initialize-release' }
WCCCounter >> initialize [ 
	counter := 0.
]

{ #category : 'initialize-release' }
WCCCounter >> renderHtmlOn: html [

	html div
		class: 'card';
		style: 'width: 10em';
		with: [
			html div
				class: 'card-header';
				with: 'A Counter'.
			html div
				class: 'card-body';
				with: [
					self
						addComponent: (WCCParagraph new
								 content: counter;
								 class: 'card-text';
								 yourself)
						named: #counter
						on: html.
					html div with:[
					self
						addComponent: (WCCButton new
								 label: '--';
								 yourself)
						named: #decrement
						on: html.

					self
						addComponent: (WCCButton new
								 label: '++';
								 yourself)
						named: #increment
						on: html ] ]]
]

{ #category : 'initialize-release' }
WCCCounter >> start [

	| incrementButton counterElement decrementButton |
	self initializeComponentHolder.
	super start.
	incrementButton := self componentNamed: #increment.
	decrementButton := self componentNamed: #decrement.
	counterElement := self componentNamed: #counter.
	incrementButton onClick: [ :event |
		counter := counter + 1.
		counterElement content: counter ].
	decrementButton onClick: [ :event |
		counter := counter - 1.
		counterElement content: counter ]
]
