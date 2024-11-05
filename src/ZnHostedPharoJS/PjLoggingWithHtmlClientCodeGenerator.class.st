Class {
	#name : 'PjLoggingWithHtmlClientCodeGenerator',
	#superclass : 'PjLoggingClientCodeGenerator',
	#category : 'ZnHostedPharoJS',
	#package : 'ZnHostedPharoJS'
}

{ #category : 'generating' }
PjLoggingWithHtmlClientCodeGenerator >> generateHtmlUsing: aCanvas [

	^ aCanvas
		  fullDocument: true;
		  rootBlock: [ :root | 
			  root beHtml5.
			  root title: self appClass title.
			  root javascript  url: '/web/index.js'.
			  self appClass updateHtmlRoot: root ];
		  render: [ :html | self appClass generateHtmlUsing: html ]
]

{ #category : 'generating' }
PjLoggingWithHtmlClientCodeGenerator >> html [

	^ self generateHtmlUsing: self htmlGenerator.
]

{ #category : 'generating' }
PjLoggingWithHtmlClientCodeGenerator >> htmlGenerator [

	^ htmlGenerator ifNil: [ htmlGenerator := WCHtmlCanvas builder ]
]
