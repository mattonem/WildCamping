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

{ #category : #comparing }
WCUrl >> = aUrl [
	^ self class = aUrl class and: [ self printString = aUrl printString ]
]

{ #category : #adding }
WCUrl >> addAllToPath: aCollectionOfStrings [
	"Add a collection of strings to the path."
	
	aCollectionOfStrings do: [ :each | self addToPath: each ]
]

{ #category : #adding }
WCUrl >> addField: aKey [
	"Add the query field aKey to the receiving url."

	self addField: aKey value: nil
]

{ #category : #adding }
WCUrl >> addField: aKey value: aValue [
	"Add the query field aKey with aValue to the receiving url."
	
	aKey isEmpty 
		ifFalse: [ self queryFields at: aKey add: aValue ]
]

{ #category : #adding }
WCUrl >> addPathParameterAt: anIndex key: aKey [
	"Add the path parameter aKey to the path element at anIndex."
	(self privatePathParameterMapAt: anIndex) at: aKey put: nil
]

{ #category : #adding }
WCUrl >> addPathParameterAt: anIndex key: aKey value: aValue [
	"Add the path parameter aKey with aKey to the path element at anIndex."
	(self privatePathParameterMapAt: anIndex) at: aKey add: aValue
]

{ #category : #adding }
WCUrl >> addToPath: aString [
	"Adds the argument as a path element. If the argument contains $/ it is split into multiple elements."

	| p |
	p := self path.
	self pathElementsIn: aString do: [ :each |
		p add: each ].
	self slash: (aString notEmpty and: [ aString last = $/ ])
]

{ #category : #private }
WCUrl >> decode: aString [
	"percent decodes the given String"

	^ self class decodePercent: aString
]

{ #category : #converting }
WCUrl >> decodedWith: aCodec [
	"answers a copy of the receiver decoded with the given codec
	http://www.ietf.org/rfc/rfc3987.txt"
	| url |
	url := self copy.
	
	"scheme, host, port cannot include escaped characters (%FF) and so should not
	be able to include characters that need decoding"
	
	"userinfo (username + password) can be percent encoded"
	self user isNil ifFalse: [
		url user: (aCodec url decode: self user) ].
	self password isNil ifFalse: [
		url password: (aCodec url decode: self password) ].
	
	self path isEmpty ifFalse: [
		url path: (self path collect: [ :each | aCodec url decode: each ]) ].
	url queryFields: nil.
	self queryFields keysAndValuesDo: [ :key :value |
		url
			addField: (aCodec url decode: key)
			value: (value isNil ifFalse: [ aCodec url decode: value ]) ].
	self fragment isNil ifFalse: [
		url fragment: (aCodec url decode: self fragment) ].
	
	^ url
]

{ #category : #private }
WCUrl >> detectCommonPathElementClass [
	"Detect if all path elements are of the same class. Answer that class if that is the case.
	Answer nil otherwise.
	
	If all the elements are of the same class we can avoid sending #contents to the wirte stream
	because we can allocate a collection of the right size and type. This is important because
	#contents does an additional copy which shows up in benchmarks.
	If the lements are not of the same class we can not know the type of the target collection
	(in a portable way) and have to use stream #contents."
	| firstSpecies |
	path isEmptyOrNil ifTrue: [
		^ '' species ].
	firstSpecies := (path at: 1) species.
	2 to: path size do: [ :index |
		(path at: index) species ~= firstSpecies
			ifTrue: [ ^ nil ] ].
	^ firstSpecies
]

{ #category : #encoding }
WCUrl >> encodeFragmentOn: aDocument [
	aDocument urlEncoder nextPutAll: fragment
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
WCUrl >> encodePathParametersAt: anIndex on: aDocument [
	self
		privatePathParameterMapAt: anIndex
		ifPresentDo: [ :parameters |
			parameters keysAndAllValuesDo: [ :key :values |
				aDocument nextPut: $;.
				aDocument urlEncoder nextPutAll: key.
				(values size = 1 and: [ values first isNil ]) ifFalse: [
					aDocument nextPut: $=.
					values
						do: [ :value | aDocument urlEncoder nextPutAll: value greaseString ]
						separatedBy: [ aDocument nextPut: $, ] ] ] ]
		ifAbsent: [ "ignore" ]
]

{ #category : #encoding }
WCUrl >> encodeQueryOn: aDocument [ 
	| first |
	first := true.
	self queryFields keysAndValuesDo: [ :key :value |
		first ifFalse: [ aDocument xmlEncoder nextPut: $& ].
		first := false.
		aDocument urlEncoder nextPutAll: key.
		value isNil ifFalse: [
			aDocument nextPut: $=.
			aDocument urlEncoder nextPutAll: value greaseString ] ]
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

{ #category : #accessing }
WCUrl >> fragment [
	"Answer the fragment part of the URL."

	^ fragment
]

{ #category : #accessing }
WCUrl >> fragment: aString [
	fragment := aString
]

{ #category : #comparing }
WCUrl >> hash [
	^ self host hash bitXor: self path hash
]

{ #category : #accessing }
WCUrl >> host [
	"Answer the host part of the URL."

	^ host
]

{ #category : #accessing }
WCUrl >> host: aString [
	host := aString isNil
		ifFalse: [ aString greaseString asLowercase ]
]

{ #category : #initialization }
WCUrl >> initialize [
	super initialize.
	slash := false
]

{ #category : #private }
WCUrl >> isSeasideField: aString [
	^ aString notEmpty
		and: [ aString first = $_
		or: [ aString allSatisfy: [ :each | each isDigit ] ] ]
]

{ #category : #testing }
WCUrl >> isSsl [
	^ self scheme isEmptyOrNil not
		and: [ self scheme last = $s ]
]

{ #category : #parsing }
WCUrl >> parseAuthority: aString from: start to: end [
	| atIndex hostStart |
	atIndex := aString indexOf: $@ startingAt: start.
	(atIndex > 0 and: [ atIndex < end ])
		ifTrue: [
			self parseUserPassword: aString from: start to: atIndex.
			hostStart := atIndex + 1 ]
		ifFalse: [
			hostStart := start ].
		
	self parseHostPort: aString from: hostStart to: end
]

{ #category : #parsing }
WCUrl >> parseFragment: aString from: startIndex [
	startIndex > aString size ifTrue: [ ^ self ].
	self fragment: (self class decodePercent: aString from: startIndex)
]

{ #category : #parsing }
WCUrl >> parseHostPort: aString from: start to: end [
	| colonIndex |
	colonIndex := aString indexOf: $: startingAt: start.
	(colonIndex > 0 and: [ colonIndex < end ])
		ifTrue: [
			start < colonIndex ifTrue: [
				"don't set host when empty"
				self host: (self class decodePercent: aString from: start to: colonIndex) ].
			self port: (self parsePort: aString from: colonIndex + 1 to: end) ]
		ifFalse: [
			start < end ifTrue: [
				"don't set host when empty"
				self host: (self class decodePercent: aString from: start to: end) ] ]
]

{ #category : #parsing }
WCUrl >> parsePath: aString [
	| absolute |
	absolute := aString notEmpty and: [ aString first = $/ ].
	self
		parsePath: aString
		absolute: absolute
		from: (absolute ifTrue: [ 2 ] ifFalse: [ 1 ])
		to: aString size + 1
]

{ #category : #parsing }
WCUrl >> parsePath: aString absolute: absolute from: start to: end [
	| p index elementStart |
	absolute ifTrue: [
		path := nil.
		pathParameters := nil ].
	p := self path.
	index := p size.
	
	elementStart := start.
	[ elementStart < end and: [ (aString at: elementStart) = $/ ] ] whileTrue: [
			elementStart := elementStart + 1 ].
	[ elementStart > 0 and: [ elementStart < end ] ] whileTrue: [
		| elementEnd elementSize |
		elementEnd := aString indexOf: $/ startingAt: elementStart + 1.
		(elementEnd > 0 and: [ elementEnd < end ]) ifFalse: [
			elementEnd := end ].
		elementSize := elementEnd - elementStart.
		elementSize > 0 ifTrue: [
			"avoid empty stings"
			(elementSize = 1 and: [ (aString at: elementStart) = $. ]) ifFalse: [ "."
				(elementSize = 2 and: [ (aString at: elementStart) = $.  and: [ (aString at: elementStart + 1) = $. ] ]) ".."
					ifTrue: [
						index := index - 1.
						"should we signal a syntax error if the path is empty?"
						p isEmpty ifFalse: [
							p removeLast ] ]
					ifFalse: [
						| semiColonIndex |
						index := index + 1.
						semiColonIndex := aString indexOf: $; startingAt: elementStart.
						(semiColonIndex > 0 and: [ semiColonIndex < elementEnd ])
							ifTrue: [			
								p addLast: (self class decodePercent: aString from: elementStart to: semiColonIndex).
								self parsePathParameters: aString at: index from: semiColonIndex + 1 to: elementEnd ]
							ifFalse: [
								p addLast: (self class decodePercent: aString from: elementStart to: elementEnd) ] ] ] ].
		elementStart := elementEnd + 1.
		[ elementStart < end and: [ (aString at: elementStart) = $/ ] ] whileTrue: [
			elementStart := elementStart + 1 ] ].
	
	slash := (end - start) > 0 and: [ (aString at: end - 1) = $/ ]
]

{ #category : #parsing }
WCUrl >> parsePathParameters: aString at: anIndex from: start to: end [
	| parameterStart |
	parameterStart := start.
	[ parameterStart > 0 and: [ parameterStart < end ] ] whileTrue: [
		| nameEnd parameterEnd |
		nameEnd := aString indexOf: $= startingAt: parameterStart.
		parameterEnd := aString indexOf: $; startingAt: parameterStart.
		parameterEnd := parameterEnd > 0
			ifTrue: [ parameterEnd min: end ]
			ifFalse: [ end ].
		(nameEnd > 0 and: [ nameEnd < end ])
			ifTrue: [
				| parameterName valueStart |
				parameterName := self class decodePercent: aString from: parameterStart to: nameEnd.
				valueStart := nameEnd + 1.
				[ valueStart > 0 and: [ valueStart < parameterEnd ] ] whileTrue: [
					| valueEnd |
					valueEnd := aString indexOf: $, startingAt: valueStart + 1.
					valueEnd := valueEnd > 0
						ifTrue: [ valueEnd min: parameterEnd ]
						ifFalse: [ parameterEnd ].
					self
						addPathParameterAt: anIndex 
						key: parameterName
						value: (self class decodePercent: aString from: valueStart to: valueEnd).
					valueStart := valueEnd + 1 ] ]
			ifFalse: [
				self addPathParameterAt: anIndex key: (self class decodePercent: aString from: parameterStart to: parameterEnd) ].
		parameterStart := parameterEnd + 1 ]
]

{ #category : #parsing }
WCUrl >> parseQuery: aString from: queryStart to: queryEnd [
	| parameterStart |
	parameterStart := queryStart.
	[ parameterStart > 0 and: [ parameterStart < queryEnd ] ] whileTrue: [
		| nameEnd parameterEnd |
		nameEnd := aString indexOf: $= startingAt: parameterStart.
		parameterEnd := aString indexOf: $& startingAt: parameterStart.
		parameterEnd := parameterEnd > 0
			ifTrue: [ parameterEnd min: queryEnd ]
			ifFalse: [ queryEnd ].
		(nameEnd > 0 and: [ nameEnd < parameterEnd ])
			ifTrue: [
				self
					addField: (self class decodePercentAndPlus: aString from: parameterStart to: nameEnd)
					value: (self class decodePercentAndPlus: aString from: nameEnd + 1 to: parameterEnd) ]
			ifFalse: [
				self addField: (self class decodePercentAndPlus: aString from: parameterStart to: parameterEnd) ].
		parameterStart := parameterEnd + 1 ]
]

{ #category : #parsing }
WCUrl >> parseUserPassword: aString from: start to: end [
	| colonIndex |
	colonIndex := aString indexOf: $: startingAt: start.
	(colonIndex > 0 and: [ colonIndex < end ])
		ifTrue: [
			self user: (self class decodePercent: aString from: start to: colonIndex).
			self password: (self class decodePercent: aString from: colonIndex + 1 to: end) ]
		ifFalse: [
			self user: (self class decodePercent: aString from: start to: end) ]
]

{ #category : #accessing }
WCUrl >> password [
	"Answer the password part of the URL userinfo. Note that the use of the format
	'user:password' for userinfo has been deprecated in RFC 3986 (3.2.1)."

	^ password
]

{ #category : #accessing }
WCUrl >> password: aString [
	password := aString
]

{ #category : #accessing }
WCUrl >> path [
	"Answer the path part of the URL."

	^ path ifNil: [ path := OrderedCollection new: 5 ]
]

{ #category : #accessing }
WCUrl >> path: aCollection [
	"Set the path part of the URL to aCollection."

	path := aCollection
]

{ #category : #private }
WCUrl >> pathElementsIn: aString do: aOneArgumentBlock [
	(aString splitOn: '/') do: aOneArgumentBlock
]

{ #category : #accessing }
WCUrl >> pathParameterAllAt: anIndex key: aKey ifAbsent: aZeroArgumentBlock [
	"Answer all the parameters at path index anIndex with key aKey evaluation aZeroArgumentBlock if none is found."
	^ self
		privatePathParameterMapAt: anIndex
		ifPresentDo: [ :parameters |
			parameters allAt: aKey ifAbsent: aZeroArgumentBlock ]
		ifAbsent: aZeroArgumentBlock
]

{ #category : #accessing }
WCUrl >> pathParameterAt: anIndex key: aKey ifAbsent: aZeroArgumentBlock [
	"Answer the first parameter at path index anIndex with key aKey evaluation aZeroArgumentBlock if none is found."
	^ self
		privatePathParameterMapAt: anIndex
		ifPresentDo: [ :parameters |
			parameters at: aKey ifAbsent: aZeroArgumentBlock ]
		ifAbsent: aZeroArgumentBlock
]

{ #category : #converting }
WCUrl >> pathStringSafeUnencoded [

	"Answer the path converted to a string without doing URL or HTML escaping.
	Compared to #pathStringUnencoded, we cannot guarantee to not copy here.
	"

	^ String
		  new: self pathStringUnencodedSize
		  streamContents: [ :stream | self pathUnencodedOn: stream ]
]

{ #category : #converting }
WCUrl >> pathStringUnencoded [

	"Answer the path converted to a string without doing URL or HTML escaping."

	"allocate with correct size, avoid copy"

	| commonElementClass |
	commonElementClass := self detectCommonPathElementClass.
	commonElementClass isNil ifTrue: [ ^ self pathStringSafeUnencoded ].

	^ String
		  new: self pathStringUnencodedSize
		  streamContents: [ :stream | self pathUnencodedOn: stream ]
]

{ #category : #private }
WCUrl >> pathStringUnencodedSize [
	| count |
	count := 0.
	path isNil ifFalse: [
		path do: [ :each |
			count := count + each size + 1 ] ].
	(path isNil or: [ path isEmpty or: [ slash ] ])
		ifTrue: [ count := count + 1 ].
	^ count
]

{ #category : #converting }
WCUrl >> pathUnencodedOn: aStream [
	"Print the path on on the given stream without doing URL or HTML escaping."

	path isNil ifFalse: [
		path do: [ :each |
			aStream nextPut: $/.
			aStream nextPutAll: each ] ].
	(path isNil or: [ path isEmpty or: [ slash ] ])
		ifTrue: [ aStream nextPut: $/ ]
]

{ #category : #accessing }
WCUrl >> port [
	"Answer the port number part of the URL."

	^ port
]

{ #category : #accessing }
WCUrl >> port: aNumber [
	port := aNumber
]

{ #category : #copying }
WCUrl >> postCopy [
	super postCopy.
	path := path ifNotNil: [ :p | p copy ].
	queryFields := queryFields ifNotNil: [ :f | f copy ].
	pathParameters := pathParameters ifNotNil: [ :p | p copy ]
]

{ #category : #printing }
WCUrl >> printOn: aStream [ 

	self encodeOn: aStream
]

{ #category : #private }
WCUrl >> privatePathParameterMapAt: anIndex ifPresentDo: aOneArgumentBlock ifAbsent: aZeroArgumentBlock [
	| parameters |
	pathParameters isNil ifTrue: [
		^ aZeroArgumentBlock value ].
	parameters := pathParameters at: anIndex ifAbsent: [
		^ aZeroArgumentBlock value ].
	parameters isNil ifTrue: [
		^ aZeroArgumentBlock value ].
	^ aOneArgumentBlock value: parameters
]

{ #category : #accessing }
WCUrl >> queryFields [
	"Answer a dictionary with the query fields."
	^ queryFields ifNil: [ queryFields := Dictionary new ]
]

{ #category : #accessing }
WCUrl >> queryFields: aDictionary [
	queryFields := aDictionary
]

{ #category : #adding }
WCUrl >> rawAddAllToPath: aCollectionOfStrings [
	"Add a collection of strings to the path. If an element contains $/ it is not split into multiple elements."
	
	aCollectionOfStrings do: [ :each | self rawAddToPath: each ]
]

{ #category : #adding }
WCUrl >> rawAddToPath: aString [
	"Adds the argument as a path element. If the argument contains $/ it is not split into multiple elements."

	self path add: aString
]

{ #category : #converting }
WCUrl >> relativeTo: aUrl [
	"Answer a path element collection relative from the receiver to aUrl."
	
	| currentPath argumentPath resultingPath |
	currentPath := self path copy.
	argumentPath := aUrl path copy.
	[ currentPath notEmpty and: [ argumentPath notEmpty and: [ currentPath first = argumentPath first ] ] ] whileTrue: [
		currentPath removeFirst.
		argumentPath removeFirst ].
	resultingPath := OrderedCollection new.
	currentPath size 
		timesRepeat: [ resultingPath add: '..' ].
	resultingPath addAll: argumentPath.
	^ resultingPath
]

{ #category : #accessing }
WCUrl >> scheme [
	"Answer the URL's scheme."

	^ scheme ifNil: [ 'http' ]
]

{ #category : #accessing }
WCUrl >> scheme: aString [
	scheme := aString isNil ifFalse: [ aString asLowercase ]
]

{ #category : #converting }
WCUrl >> seasideUrl [
	^ self
]

{ #category : #accessing }
WCUrl >> slash [
	"Answer if the path has a trailing slash."

	^ slash
]

{ #category : #accessing }
WCUrl >> slash: aBoolean [
	slash := aBoolean
]

{ #category : #private }
WCUrl >> takeServerParametersFromRequest: aRequest [
	"Retrieves scheme, hostname and basepath from the request unless already set."

	scheme isNil
		ifTrue: [ self scheme: aRequest url scheme ].
	host isNil 
		ifTrue: [ aRequest headers at: 'host' ifPresent: [ :value | self parseAuthority: value from: 1 to: value size + 1 ] ].
	path isNil
		ifTrue: [ aRequest headers at: 'base' ifPresent: [ :value | self parsePath: value ] ]
]

{ #category : #accessing }
WCUrl >> user [
	"Answer the user part of the URL userinfo. Note that the use of the format
	'user:password' for userinfo has been deprecated in RFC 3986 (3.2.1)."

	^ user
]

{ #category : #accessing }
WCUrl >> user: aString [
	user := aString
]

{ #category : #accessing }
WCUrl >> userinfo [
	"Answer the userinfo part of the URL. We store user and password separately,
	even though the format 'user:password' is deprecated for userinfo in RFC 3986,
	because otherwise it is impossible to figure out correct encoding when userinfo
	data has a colon in it."

	^ password isNil
		ifTrue: [ user ]
		ifFalse: [ String streamContents: [ :stream |
			stream
				nextPutAll: user;
				nextPut: $:;
				nextPutAll: password ] ]
]

{ #category : #accessing }
WCUrl >> userinfo: aString [
	"Colons in userinfo must be encoded. The only exception (now deprecated by RFC 3986)
	is a single colon separating a password from the rest of the user information. Since
	we can't tell the difference here, we assume that any colons should be encoded. If
	you want to specify a (deprecated) password, use #user: and #password:."
	
	user := aString.
	password := nil
]

{ #category : #copying }
WCUrl >> with: pathString [
	^ self copy
		addToPath: pathString;
		yourself
]

{ #category : #copying }
WCUrl >> withField: aString [
	^ self copy
		addField: aString;
		yourself
]

{ #category : #copying }
WCUrl >> withField: aString value: valueString [
	^ self copy
		addField: aString value: valueString;
		yourself
]

{ #category : #copying }
WCUrl >> withoutFragment [
	^ self copy
		fragment: nil;
		yourself
]

{ #category : #copying }
WCUrl >> withoutQuery [
	^ self copy
		queryFields: nil;
		yourself
]

{ #category : #copying }
WCUrl >> withoutResource [

	^ self copy
		  path: OrderedCollection new;
		  queryFields: nil;
		  fragment: nil;
		  yourself
]

{ #category : #copying }
WCUrl >> withoutSeasideQueryFields [

	"Returns a copy of receiver without Seaside query fields (which are prefixed with `_`)"

	| newUrl |
	newUrl := self copy.
	(self queryFields keys select: [ :f | self isSeasideField: f ]) 
		do: [ :f | newUrl queryFields removeKey: f ifAbsent: [  ] ].
	^ newUrl
]
