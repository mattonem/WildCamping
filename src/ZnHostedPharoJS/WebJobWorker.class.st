Class {
	#name : 'WebJobWorker',
	#superclass : 'WebWorker',
	#category : 'ZnHostedPharoJS-Objects',
	#package : 'ZnHostedPharoJS',
	#tag : 'Objects'
}

{ #category : 'private' }
WebJobWorker class >> createWorker: aClass [

	^ WebJobWorkerWrapper new: aClass appJsFileName
]

{ #category : 'start-stop' }
WebJobWorker >> start [

	onmessage := [ :aMessage |
	             | job |
	             job := PhxJsonReader readFromString: aMessage data.
	             job data: (self onMessage: job data).
	             self postMessage: job ]
]
