Class {
	#name : 'WebJobWorkerWrapper',
	#superclass : 'WebWorkerWrapper',
	#instVars : [
		'jobs'
	],
	#category : 'ZnHostedPharoJS-Objects',
	#package : 'ZnHostedPharoJS',
	#tag : 'Objects'
}

{ #category : 'as yet unclassified' }
WebJobWorkerWrapper >> initialize [

	super initialize.
	jobs := Dictionary new
]

{ #category : 'as yet unclassified' }
WebJobWorkerWrapper >> postMessage: anObject [

	| aJob |
	aJob := WWJob new
		        data: anObject;
		        yourself.
	jobs at: aJob id put: aJob.
	worker postMessage: aJob asPhxJsonString.
	^ aJob
]

{ #category : 'as yet unclassified' }
WebJobWorkerWrapper >> worker: aWorker [

	worker := aWorker.
	worker onmessage: [ :aMessage |
		| aJob originJob |
		aJob := PhxJsonReader readFromString: aMessage data.
		originJob := jobs removeKey: aJob id.
		originJob ifNotNil: [
			originJob finish: aJob data ] ]
]
