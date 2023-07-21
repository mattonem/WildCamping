Trait {
	#name : #WCBuilderCanvasTestTrait,
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #tests }
WCBuilderCanvasTestTrait >> testBody [

	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html unorderedList with: [ html listItem with: 'an item' ] ] ]
		gives: '<ul><li>an item</li></ul>'
]

{ #category : #tests }
WCBuilderCanvasTestTrait >> testFullDocument [

	self
		assert: [
			WCHtmlCanvas  builder fullDocument: true; render: [ :html |
		html unorderedList with: [
			html listItem with: 'an item' ] ].]
		gives: '<html><head><title></title></head><body><ul><li>an item</li></ul></body></html>'.

]

{ #category : #tests }
WCBuilderCanvasTestTrait >> testFullDocumentWithBlock [
	self skip.
	self
		assert: [
			WCHtmlCanvas builder
				fullDocument: true;
				rootBlock: [ :root |
					root title: 'title'.
					root stylesheet add: 'body{font-size:12px;}'.
					root javascript add: 'alert("loaded")' ];
				render: [ :html |
					html unorderedList with: [ html listItem with: 'an item' ] ] ]
		gives:
		'<html><head><title>title</title><style type="text/css" rel="stylesheet">body{font-size:12px;}</style><script type="text/javascript">alert("loaded")</script></head><body><ul><li>an item</li></ul></body></html>'
]
