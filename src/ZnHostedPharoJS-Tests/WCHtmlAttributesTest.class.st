"
A WCHtmlAttributesTest is a test class for testing the behavior of WCHtmlAttributes
"
Class {
	#name : #WCHtmlAttributesTest,
	#superclass : #TestCase,
	#instVars : [
		'attributes'
	],
	#category : #'ZnHostedPharoJS-Tests'
}

{ #category : #tests }
WCHtmlAttributesTest >> assert: aBlock gives: aString [

	| stream |
	aBlock value: (attributes := WCHtmlAttributes new).
	(WCHtmlDocument on: (stream := WriteStream on: String new)) print:
		attributes.
	self
		assert: stream contents = aString
		description: 'Expected ' , aString printString , ', but got '
			, stream contents printString
		resumable: true
]

{ #category : #tests }
WCHtmlAttributesTest >> setUp [
	attributes := WCHtmlAttributes new.
	super setUp 
]

{ #category : #tests }
WCHtmlAttributesTest >> testAddClass [
	self
		assert: [ :attr | attr addClass: 'foo' ]
		gives: ' class="foo"'.
	self
		assert: [ :attr | attr addClass: 'foo'; addClass: 'bar' ]
		gives: ' class="foo bar"'
]

{ #category : #tests }
WCHtmlAttributesTest >> testAtAppend [
	self
		assert: [ :attr | attr at: 'onclick' append: 'this' separator: ';' ]
		gives: ' onclick="this"'.
	self
		assert: [ :attr |
			attr
				at: 'onclick' append: 'this' separator: ';';
				at: 'onclick' append: 'that' separator: ';' ]
		gives: ' onclick="this;that"'.
	self
		assert: [ :attr |
			attr
				at: 'onclick' append: 'this' separator: ';';
				at: 'onclick' append: nil separator: ';' ]
		gives: ' onclick="this"'.
	self
		assert: [ :attr |
			attr
				at: 'onclick' append: 1 separator: ';';
				at: 'onclick' append: 2 separator: ';' ]
		gives: ' onclick="1;2"'
]

{ #category : #tests }
WCHtmlAttributesTest >> testAtPut [
	self
		assert: [ :attr | attr at: 'id' put: 'foo' ]
		gives: ' id="foo"'.
	self
		assert: [ :attr | attr at: 'tabindex' put: 6 ]
		gives: ' tabindex="6"'.
	self
		assert: [ :attr | attr at: 'checked' put: true ]
		gives: ' checked'.
	self
		assert: [ :attr | attr at: 'readonly' put: false ]
		gives: ''.
	self
		assert: [ :attr | attr at: 'disabled' put: nil ]
		gives: ''
]

{ #category : #tests }
WCHtmlAttributesTest >> testCaseSensititve [
	self
		assert: [ :attr | attr at: 'lastBuildDate' put: 'Sat, 07 Sep 2002 09:42:31 GMT' ]
		gives: ' lastBuildDate="Sat, 07 Sep 2002 09:42:31 GMT"'
]

{ #category : #tests }
WCHtmlAttributesTest >> testOrder [
	self
		assert: [ :attr | attr at: 'a' put: 1; at: 'b' put: 2; at: 'c' put: 3 ]
		gives: ' a="1" b="2" c="3"'.
	self
		assert: [ :attr | attr at: 'a' put: 1; at: 'b' put: 2; at: 'c' put: 3; at: 'b' put: 4 ]
		gives: ' a="1" b="4" c="3"'
]

{ #category : #tests }
WCHtmlAttributesTest >> testRemoveKey [

	attributes at: 'id' put: 'foo'.
	self assert: (attributes removeKey: 'id') = 'foo'.
	self assert: (attributes removeKey: 'id') isNil
]
