Class {
	#name : #ZnHostedCodeGenerator,
	#superclass : #PjClientCodeGenerator,
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
ZnHostedCodeGenerator >> generateHtmlUsing: aCanvas [

	^ aCanvas
		  fullDocument: true;
		  rootBlock: [ :root | 
			  root beHtml5.
			  root title: self appClass title.
			  root javascript url: '/web/index.js'.
			  self appClass updateHtmlRoot: root ];
		  render: [ :html | self appClass generateHtmlUsing: html ]
]

{ #category : #accessing }
ZnHostedCodeGenerator >> html [

	^ self generateHtmlUsing: self htmlGenerator.
]

{ #category : #accessing }
ZnHostedCodeGenerator >> htmlGenerator [

	^ htmlGenerator ifNil: [ htmlGenerator := WCHtmlCanvas builder ]
]
