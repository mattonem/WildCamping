Class {
	#name : #WCGeoHash,
	#superclass : #Object,
	#category : #WCGeoHash
}

{ #category : #'as yet unclassified' }
WCGeoHash class >> binaryFor: aString [

	| power result |
	result := 0.
	power := 1.
	aString reverseDo: [ :aChar |
		result := result
		          + (power * ((self characterList indexOf: aChar) - 1)).
		power := power * 32 ].
	^ result
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> characterList [
	^ '0123456789bcdefghjkmnpqrstuvwxyz'
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> hashOf: aPoint [
	^ self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
WCGeoHash class >> hashOf: coordinate precision: precision [

	| idx bit evenBit geohash lat lon lonMin lonMax latMin latMax |
	lat := coordinate x.
	lon := coordinate y.
	idx := 0.
	bit := 0.
	evenBit := true.
	geohash := ''.
	lonMin := -180.
	lonMax := 180.
	latMin := -90.
	latMax := 90.
	[ geohash size < precision ] whileTrue: [
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
			geohash := geohash copyWith: (self characterList at: idx + 1).
			bit := 0.
			idx := 0 ] ].
	^ geohash
]
