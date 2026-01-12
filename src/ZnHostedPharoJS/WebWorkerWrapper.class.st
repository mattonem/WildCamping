Class {
	#name : 'WebWorkerWrapper',
	#superclass : 'Object',
	#instVars : [
		'worker',
		'announcer'
	],
	#pools : [
		'WebWorkerGlobals'
	],
	#category : 'ZnHostedPharoJS-Objects',
	#package : 'ZnHostedPharoJS',
	#tag : 'Objects'
}

{ #category : 'instance creation' }
WebWorkerWrapper class >> new: aFileName [

	^ self new
		  worker: (Worker new: aFileName);
		  yourself
]

{ #category : 'as yet unclassified' }
WebWorkerWrapper >> announcer [

	^ announcer
]

{ #category : 'as yet unclassified' }
WebWorkerWrapper >> initialize [

	announcer := Announcer new
]

{ #category : 'as yet unclassified' }
WebWorkerWrapper >> postMessage: anObject [
	^ worker postMessage: anObject asPhxJsonString 
]

{ #category : 'as yet unclassified' }
WebWorkerWrapper >> worker: aWorker [

	worker := aWorker.
	worker onmessage: [ :aMessage |
		announcer announce: (PhxJsonReader readFromString: aMessage data) ]
]
