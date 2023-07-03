Class {
	#name : #WCXmlEncoder,
	#superclass : #WCEncoder,
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCXmlEncoder >> nextPut: aCharacter [
	stream nextPut: aCharacter
]

{ #category : #accessing }
WCXmlEncoder >> nextPutAll: aString [
	"uses #to:do: for speed reasons (on Pharo)
	this is not premature optimization, this is a hotspot method method
	and #to:do: shows measurable speed improvements for rendering seaside pages"
	1 to: aString size do: [ :index |
		self nextPut: (aString at: index) ]
]
