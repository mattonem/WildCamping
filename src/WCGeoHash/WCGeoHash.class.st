Class {
	#name : #WCGeoHash,
	#superclass : #Object,
	#instVars : [
		'byteArray'
	],
	#category : #WCGeoHash
}

{ #category : #'as yet unclassified' }
WCGeoHash class >> characterList [
	^ '0123456789bcdefghjkmnpqrstuvwxyz'
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> fromByteArray: aByteArray [

	^ self new
		  byteArray: aByteArray;
		  yourself
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> fromInteger: anInteger precision: aPrecision [

	^ self new
		  integer: anInteger;
		  precision: aPrecision;
		  yourself
]

{ #category : #'instance creation' }
WCGeoHash class >> fromString: aString [

	^ self new
		  byteArray: (aString asOrderedCollection collect: [ :aCharacter |
					   (self characterList indexOf: aCharacter) - 1 ]);
		  yourself
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> hashFor: coordinate precision: precision [

	| idx bit evenBit geohash lat lon lonMin lonMax latMin latMax currentPrecision |
	lat := coordinate x.
	lon := coordinate y.
	idx := 0.
	bit := 0.
	evenBit := true.
	currentPrecision := 0.
	geohash := ByteArray new: precision.
	lonMin := -180.
	lonMax := 180.
	latMin := -90.
	latMax := 90.
	[ currentPrecision < precision ] whileTrue: [
		evenBit
			ifTrue: [
				| lonMid |
				lonMid := lonMin + lonMax / 2.
				lon >= lonMid
					ifTrue: [
						idx := idx * 2 + 1.
						lonMin := lonMid ]
					ifFalse: [
						idx := idx * 2.
						lonMax := lonMid ] ]
			ifFalse: [
				| latMid |
				latMid := latMin + latMax / 2.
				lat >= latMid
					ifTrue: [
						idx := idx * 2 + 1.
						latMin := latMid ]
					ifFalse: [
						idx := idx * 2.
						latMax := latMid ] ].
		evenBit := evenBit not.
		bit := bit + 1.
		bit = 5 ifTrue: [
			currentPrecision := currentPrecision + 1.
			geohash byteAt: currentPrecision put: idx.
			bit := 0.
			idx := 0 ] ].
	^ self fromByteArray: geohash
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> hashOf: coordinate precision: precision [

	^ (self hashFor: coordinate precision: precision) stringAddress
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> northDirection [
	^ 0
]

{ #category : #'as yet unclassified' }
WCGeoHash >> adjacentWithBorder: borders andNeighbours: neighbours [

	| parent |
	parent := self parent.
	((borders at: self type) includes: byteArray last) ifTrue: [
		parent := parent
			          adjacentWithBorder: borders
			          andNeighbours: neighbours ].
	^ WCGeoHash fromByteArray: (parent byteArray copyWith:
			   ((neighbours at: self type) indexOf: byteArray last) - 1)
]

{ #category : #accessing }
WCGeoHash >> allNeighbours [

	| temp result |
	temp := self.
	result := OrderedCollection new.
	result add: (temp := temp north).
	result add: (temp := temp east).
	result add: (temp := temp south).
	result add: (temp := temp south).
	result add: (temp := temp west).
	result add: (temp := temp west).
	result add: (temp := temp north).
	result add: (temp := temp north).
	^ result
]

{ #category : #'as yet unclassified' }
WCGeoHash >> byteArayToString [

	^ String streamContents: [ :s |
		  s << '#['.
		  byteArray do: [ :el | el printOn: s ] separatedBy: [ s << ' ' ].
		  s << ']' ]
]

{ #category : #accessing }
WCGeoHash >> byteArray [
	^ byteArray
]

{ #category : #accessing }
WCGeoHash >> byteArray: aCollection [

	aCollection do: [ :aByte |
		aByte <= self maxByteValue ifFalse: [
			Exception signal: 'Geohash bytes cannot be higher than 31' ] ].
	byteArray := aCollection
]

{ #category : #accessing }
WCGeoHash >> byteAt: anInteger [ 
	^ byteArray byteAt: anInteger 
]

{ #category : #'as yet unclassified' }
WCGeoHash >> characterFor: anInteger [ 
	^ (self class characterList at: anInteger + 1)
]

{ #category : #'as yet unclassified' }
WCGeoHash >> east [

	byteArray ifEmpty: [ ^ self ].
	^ self
		  adjacentWithBorder: self eastBorders
		  andNeighbours: self eastNeighbours
]

{ #category : #'as yet unclassified' }
WCGeoHash >> eastBorders [
	"	(WCGeoHash fromString: 'prxz')
		byteArayToString."

	^ {
		  #[10 11 14 15 26 27 30 31].
		  #[21 23 29 31] }
]

{ #category : #'as yet unclassified' }
WCGeoHash >> eastNeighbours [
	"	(WCGeoHash fromString: 'p0r21436x8zb9dcf5h7kjnmqesgutwvy')
		byteArayToString.
		"

	^ {
		  #[ 10 11 0 1 14 15 4 5 2 3 8 9 6 7 12 13 26 27 16 17 30 31 20 21
		     18 19 24 25 22 23 28 29 ].
		  #[ 21 0 23 2 1 4 3 6 29 8 31 10 9 12 11 14 5 16 7 18 17 20 19 22
		     13 24 15 26 25 28 27 30 ] }
]

{ #category : #accessing }
WCGeoHash >> maxByteValue [

	^ 31
]

{ #category : #'as yet unclassified' }
WCGeoHash >> north [

	byteArray ifEmpty: [ ^ self ].
	^ self
		  adjacentWithBorder: self northBorders
		  andNeighbours: self northNeighbours
]

{ #category : #'as yet unclassified' }
WCGeoHash >> northBorders [

	^ {
		  #[ 21 23 29 31 ].
		  #[ 10 11 14 15 26 27 30 31 ] }
]

{ #category : #'as yet unclassified' }
WCGeoHash >> northNeighbours [
	"	(WCGeoHash fromString: 'p0r21436x8zb9dcf5h7kjnmqesgutwvy')
		byteArayToString."

	^ {
		  #[ 21 0 23 2 1 4 3 6 29 8 31 10 9 12 11 14 5 16 7 18 17 20 19 22
		     13 24 15 26 25 28 27 30 ].
		  #[ 10 11 0 1 14 15 4 5 2 3 8 9 6 7 12 13 26 27 16 17 30 31 20 21
		     18 19 24 25 22 23 28 29 ] }
]

{ #category : #accessing }
WCGeoHash >> parent [
	^ self class fromByteArray: byteArray allButLast 
]

{ #category : #constants }
WCGeoHash >> precision [

	^ byteArray size
]

{ #category : #'as yet unclassified' }
WCGeoHash >> printOn: stream [

	<ingnoreForCoverage>
	super printOn: stream.
	stream nextPut: $(.
	self stringAddress printOn: stream.
	stream nextPut: $)
]

{ #category : #'as yet unclassified' }
WCGeoHash >> south [

	byteArray ifEmpty: [ ^ self ].
	^ self
		  adjacentWithBorder: self southBorders
		  andNeighbours: self southNeighbours
]

{ #category : #'as yet unclassified' }
WCGeoHash >> southBorders [

	^ {
		  #[ 0 2 8 10 ].
		  #[ 0 1 4 5 16 17 20 21 ] }
]

{ #category : #'as yet unclassified' }
WCGeoHash >> southNeighbours [

	^ {
		  #[ 1 4 3 6 5 16 7 18 9 12 11 14 13 24 15 26 17 20 19 22 21 0 23 2
		     25 28 27 30 29 8 31 10 ].
		  #[ 2 3 8 9 6 7 12 13 10 11 0 1 14 15 4 5 18 19 24 25 22 23 28 29
		     26 27 16 17 30 31 20 21 ] }
]

{ #category : #'as yet unclassified' }
WCGeoHash >> stringAddress [

	^ String
		  new: self precision
		  streamContents: [ :s |
		  byteArray do: [ :aByte | s nextPut: (self characterFor: aByte) ] ]
]

{ #category : #accessing }
WCGeoHash >> type [
 ^ (self precision \\ 2) + 1
]

{ #category : #'as yet unclassified' }
WCGeoHash >> west [

	byteArray ifEmpty: [ ^ self ].
	^ self
		  adjacentWithBorder: self westBorders
		  andNeighbours: self westNeighbours
]

{ #category : #'as yet unclassified' }
WCGeoHash >> westBorders [
	"	(WCGeoHash fromString: '028b')
		byteArayToString."

	^ {
		  #[ 0 1 4 5 16 17 20 21 ].
		  #[ 0 2 8 10 ] }
]

{ #category : #'as yet unclassified' }
WCGeoHash >> westNeighbours [
	"	(WCGeoHash fromString: '14365h7k9dcfesgujnmqp0r2twvyx8zb')
		byteArayToString."

	^ {
		  #[ 2 3 8 9 6 7 12 13 10 11 0 1 14 15 4 5 18 19 24 25 22 23 28 29
		     26 27 16 17 30 31 20 21 ].
		  #[ 1 4 3 6 5 16 7 18 9 12 11 14 13 24 15 26 17 20 19 22 21 0 23 2
		     25 28 27 30 29 8 31 10 ] }
]
