Extension { #name : 'PjBridgeAppClassDecorator' }

{ #category : '*ZnHostedPharoJS' }
PjBridgeAppClassDecorator >> generateHtmlUsing: aWCHtmlCanvas [ 
	^ rawAppClass generateHtmlUsing: aWCHtmlCanvas 
]

{ #category : '*ZnHostedPharoJS' }
PjBridgeAppClassDecorator >> title [
	^ rawAppClass title
]

{ #category : '*ZnHostedPharoJS' }
PjBridgeAppClassDecorator >> updateHtmlRoot: aWCHtmlRoot [ 
	^ rawAppClass updateHtmlRoot: aWCHtmlRoot 
]
