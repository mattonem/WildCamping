Class {
	#name : #WCUrl,
	#superclass : #Object,
	#instVars : [
		'scheme',
		'user',
		'password',
		'host',
		'port',
		'path',
		'slash',
		'queryFields',
		'fragment',
		'pathParameters'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #adding }
WCUrl >> addToPath: aString [
	"Adds the argument as a path element. If the argument contains $/ it is split into multiple elements."

	| p |
	p := self path.
	self pathElementsIn: aString do: [ :each |
		p add: each ].
	self slash: (aString notEmpty and: [ aString last = $/ ])
]

{ #category : #encoding }
WCUrl >> encodeOn: aDocument [
	self encodeSchemeAndAuthorityOn: aDocument.
	self encodePathOn: aDocument.
	(queryFields isNil or: [ queryFields isEmpty ]) ifFalse: [
		aDocument xmlEncoder nextPut: $?.
		self encodeQueryOn: aDocument ].
	fragment isNil ifFalse: [
		aDocument xmlEncoder nextPut: $#.
		self encodeFragmentOn: aDocument ]
]

{ #category : #encoding }
WCUrl >> encodePathOn: aDocument [
	path isNil ifFalse: [
		path keysAndValuesDo: [ :index :each |
			aDocument nextPut: $/.
			aDocument urlEncoder nextPutAll: each.
			pathParameters isNil ifFalse: [
				self encodePathParametersAt: index on: aDocument ] ] ].
	(path isNil or: [ path isEmpty or: [ slash ] ])
		ifTrue: [ aDocument nextPut: $/ ]
]

{ #category : #encoding }
WCUrl >> encodeSchemeAndAuthorityOn: aDocument [
	host ifNil: [ ^ self ].
	aDocument nextPutAll: self scheme; nextPutAll: '://'.
	user notNil ifTrue: [
		aDocument urlEncoder nextPutAll: user.
		password notNil ifTrue: [
			aDocument nextPut: $:.
			aDocument urlEncoder nextPutAll: password ].
		aDocument nextPut: $@ ].
	aDocument urlEncoder nextPutAll: host.
	port notNil ifTrue: [
		((self scheme = 'http' and: [ port = 80 ])
			or: [ self scheme = 'https' and: [ port = 443 ] ])
			ifFalse: [ aDocument nextPut: $:; print: port ] ]
]

{ #category : #initialization }
WCUrl >> initialize [
	super initialize.
	slash := false
]

{ #category : #accessing }
WCUrl >> path [
	"Answer the path part of the URL."

	^ path ifNil: [ path := OrderedCollection new: 5 ]
]

{ #category : #private }
WCUrl >> pathElementsIn: aString do: aOneArgumentBlock [
	(aString splitOn: '/') do: aOneArgumentBlock
]

{ #category : #accessing }
WCUrl >> slash: aBoolean [
	slash := aBoolean
]
