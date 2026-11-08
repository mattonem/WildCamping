Trait {
	#name : 'WCBuilderCanvasTestTrait',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'tests' }
WCBuilderCanvasTestTrait >> testBody [

	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html unorderedList with: [ html listItem with: 'an item' ] ] ]
		gives: '<ul><li>an item</li></ul>'
]

{ #category : 'tests' }
WCBuilderCanvasTestTrait >> testDiv [

	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html div
					id: 'anId';
					with: [ html span with: 'an item' ] ] ]
		gives: '<div id="anId"><span>an item</span></div>'.
	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html div
					class: 'aClass';
					with: [ html span with: 'an item' ] ] ]
		gives: '<div class="aClass"><span>an item</span></div>'
]

{ #category : 'tests' }
WCBuilderCanvasTestTrait >> testSemanticAndTextTags [
	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html article with: [
					html header with: [ html strong with: 'Title' ].
					html main with: [
						html blockquote with: [ html code with: 'example' ] ] ] ] ]
		gives: '<article><header><strong>Title</strong></header><main><blockquote><code>example</code></blockquote></main></article>'.
	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html descriptionList with: [
					html descriptionTerm with: 'Term'.
					html descriptionDefinition with: 'Definition' ] ] ]
		gives: '<dl><dt>Term</dt><dd>Definition</dd></dl>'.
	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html navigation with: [
					html orderedList with: [ html listItem with: 'First' ] ].
				html details with: [ html summary with: 'More' ].
				html figure with: [ html figcaption with: 'Caption' ].
				html aside with: [ html mark with: [ html emphasis with: 'Note' ] ].
				html footer with: [ html time with: 'Today' ] ] ]
		gives: '<nav><ol><li>First</li></ol></nav><details><summary>More</summary></details><figure><figcaption>Caption</figcaption></figure><aside><mark><em>Note</em></mark></aside><footer><time>Today</time></footer>'
]

{ #category : 'tests' }
WCBuilderCanvasTestTrait >> testForm [

	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html form
					id: 'anId';
					with: [
						html textInput
							"maxLength: 1."] ] ]
		gives:
		'<form id="anId"><input type="text"/></form>'.
	self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html form with: [
					html textInput
						placeholder: 'placeholder'] ] ]
		gives:
		'<form><input placeholder="placeholder" type="text"/></form>'.
		self
		assert: [
			WCHtmlCanvas builder render: [ :html |
				html form with: [
					html textInput
						with: 'value'] ] ]
		gives:
		'<form><input value="value" type="text"/></form>'
]

{ #category : 'tests' }
WCBuilderCanvasTestTrait >> testFullDocument [

	self
		assert: [
			WCHtmlCanvas  builder fullDocument: true; render: [ :html |
		html unorderedList with: [
			html listItem with: 'an item' ] ].]
		gives: '<html><head><title></title></head><body><ul><li>an item</li></ul></body></html>'.

]

{ #category : 'tests' }
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
