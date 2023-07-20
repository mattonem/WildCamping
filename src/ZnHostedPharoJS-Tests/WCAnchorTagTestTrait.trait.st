Trait {
	#name : #WCAnchorTagTestTrait,
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #'tests-tags-anchors' }
WCAnchorTagTestTrait >> testAnchor [
	self
		assert: [ WCHtmlCanvas builder render: [:html |  ]]
		gives: '<a></a>'.
	self
		assert: [ :html | html anchor with: 'foo' ]
		gives: '<a>foo</a>'.
	self
		assert: [ :html |
			html anchor with: 'foo'.
			html anchor  with: 'bar' ]
		gives: '<a>foo</a><a>bar</a>'.
	self
		assert: [ :html |
			html anchor
				extraPath: 'zork';
				with: 'foo' ]
		gives: '<a href="/zork">foo</a>'.
	self
		assert: [ :html |
			html anchor
				extraParameters: 'zork';
				with: 'foo' ]
		gives: '<a href="/?zork">foo</a>'
]

{ #category : #'tests-tags-anchors' }
WCAnchorTagTestTrait >> testAnchorAttributes [
	self
		assert: [ :html | html anchor charset: 'utf-8' ]
		gives: '<a charset="utf-8"></a>'.
	self
		assert: [ :html | html anchor name: 'foo' ]
		gives: '<a name="foo"></a>'.
	self
		assert: [ :html | html anchor relationship: 'home' ]
		gives: '<a rel="home"></a>'.
	self
		assert: [ :html | html anchor relationship: 'home'; relationship: 'parent' ]
		gives: '<a rel="home parent"></a>'.
	self
		assert: [ :html | html anchor reverse: 'home' ]
		gives: '<a rev="home"></a>'.
	self
		assert: [ :html | html anchor reverse: 'home'; reverse: 'parent' ]
		gives: '<a rev="home parent"></a>'.
	self
		assert: [ :html | html anchor target: '_new' ]
		gives: '<a target="_new"></a>'.
	self
		assert: [ :html | html anchor type: 'text/plain' ]
		gives: '<a type="text/plain"></a>'
]

{ #category : #'tests-tags-anchors' }
WCAnchorTagTestTrait >> testAnchorUrl [
	| url string |
	1 skip.
	url := WCUrl new.
	url
		host: 'www.seaside.st';
		addToPath: 'foo bar&zork<blah';
		addField: '1' value: nil;
		addField: '2' value: 123;
		addField: '3' value: 'foo bar&zork'.
	string := 'http://www.seaside.st/foo%20bar%26zork%3Cblah?1&2=123&3=foo%20bar%26zork'.
	self
		assert: [ :html | html anchor url: url; with: url ]
		gives: '<a href="' , string , '">' , string , '</a>'
]

{ #category : #tests }
WCAnchorTagTestTrait >> testTargetBlank [
	self
		assert: [ :html | 
			html anchor
				targetBlank;
				with: 'foo' ]
		gives: '<a target="_blank">foo</a>'
]

{ #category : #tests }
WCAnchorTagTestTrait >> testTargetParent [
	self
		assert: [ :html | 
			html anchor
				targetParent;
				with: 'foo' ]
		gives: '<a target="_parent">foo</a>'
]

{ #category : #tests }
WCAnchorTagTestTrait >> testTargetSelf [
	self
		assert: [ :html | 
			html anchor
				targetSelf;
				with: 'foo' ]
		gives: '<a target="_self">foo</a>'
]

{ #category : #tests }
WCAnchorTagTestTrait >> testTargetTop [
	self
		assert: [ :html | 
			html anchor
				targetTop;
				with: 'foo' ]
		gives: '<a target="_top">foo</a>'
]
