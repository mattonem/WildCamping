Class {
	#name : 'WCAutoForm',
	#superclass : 'WCComponent',
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#instVars : [
		'model'
	],
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'accessing' }
WCAutoForm >> model [

	^ model
]

{ #category : 'accessing' }
WCAutoForm >> model: anObject [

	model := anObject
]

{ #category : 'rendering' }
WCAutoForm >> renderHtmlOn: html [

	html div
		id: #form;
		with: [ model ifNotNil: [ self renderModelOn: html ].
			html button class: 'btn btn-primary'; with: 'Submit'. ]
]

{ #category : 'rendering' }
WCAutoForm >> renderModelOn: html [ 
	model description do: [ :each | each renderDescriptionOn: self with: html]
]

{ #category : 'rendering' }
WCAutoForm >> renderString: aWCStingDescription with: html [

	html div
		class: 'input-group mb-3';
		with: [ :content |
			aWCStingDescription label ifNotNil: [
					content label
						class: 'form-label';
						for: aWCStingDescription id;
						with:  aWCStingDescription label  ].
			content textInput
				id: aWCStingDescription id;
				class: 'form-control';
				value: (model perform: aWCStingDescription getter) ]
]
