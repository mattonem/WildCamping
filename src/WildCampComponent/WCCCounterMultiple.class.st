Class {
	#name : #WCCCounterMultiple,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : #'WildCampComponent-Examples'
}

{ #category : #rendering }
WCCCounterMultiple >> renderHtmlOn: html [

	html div id: #counters.
	html div id: #buttons; with: [
		self
			addComponent: (WCCButton new
					 label: 'New Counter';
					 on: html)
			named: #newCounter ]
]

{ #category : #rendering }
WCCCounterMultiple >> start [

	| addButton |
	self initializeComponentHolder.
	super start.
	addButton := self componentNamed: #newCounter.
	addButton onClick: [ :event |
		self
			addComponent: WCCCounter  new
			in: (self getElementById: #counters) ]
]
