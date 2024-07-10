Class {
	#name : 'WCMetaElement',
	#superclass : 'WCHtmlElement',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCMetaElement >> language: aString [
	self attributeAt: 'lang' put: aString
]

{ #category : 'accessing' }
WCMetaElement >> tag [
	^ 'meta'
]
