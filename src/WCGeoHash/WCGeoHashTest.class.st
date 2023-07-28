"
A GeoHashTest is a test class for testing the behavior of GeoHash
"
Class {
	#name : #WCGeoHashTest,
	#superclass : #TestCase,
	#category : #'WCGeoHash-Tests'
}

{ #category : #tests }
WCGeoHashTest >> testBinaryConvert [

	self assert: (WCGeoHash binaryFor: '123') equals: 32r123.
	self assert: (WCGeoHash binaryFor: 'ezs42') equals: 14672002
]

{ #category : #tests }
WCGeoHashTest >> testEncode [

	self assert: (WCGeoHash hashOf: (20@10) precision: 9) equals: 's5x1g8cu2' .
	self assert: (WCGeoHash hashOf: (48.669@(-4.329)) precision: 1) equals: 'g' .
	self assert: (WCGeoHash hashOf: (48.669@(-4.329)) precision: 5) equals: 'gbsuv'.
]
