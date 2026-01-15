Class {
	#name : 'WWJob',
	#superclass : 'Object',
	#instVars : [
		'id',
		'data',
		'callbackBlock'
	],
	#pools : [
		'WebWorkerGlobals'
	],
	#category : 'ZnHostedPharoJS-Objects',
	#package : 'ZnHostedPharoJS',
	#tag : 'Objects'
}

{ #category : 'as yet unclassified' }
WWJob >> allPhxJsonInstvarNames [
	^ super allPhxJsonInstvarNames copyWithout: #callbackBlock
]

{ #category : 'accessing' }
WWJob >> callbackBlock: anObject [

	callbackBlock := anObject
]

{ #category : 'accessing' }
WWJob >> data [

	^ data
]

{ #category : 'accessing' }
WWJob >> data: anObject [

	data := anObject
]

{ #category : 'accessing' }
WWJob >> finish: anObject [

	callbackBlock ifNotNil: [ callbackBlock value: anObject ]
]

{ #category : 'accessing' }
WWJob >> id [

	^ id
]

{ #category : 'accessing' }
WWJob >> initialize [ 
	id := WCUUIDGeneratorWrapper next
]
