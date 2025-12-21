Class {
	#name : 'WCBreakTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'initialize-release' }
WCBreakTag >> isClosed [
	^ true
]

{ #category : 'accessing' }
WCBreakTag >> tag [
	^ 'br'
]
