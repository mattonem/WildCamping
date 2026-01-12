Class {
	#name : 'WebWorker',
	#superclass : 'PjApplication',
	#pools : [
		'WebWorkerGlobals'
	],
	#category : 'ZnHostedPharoJS-Objects',
	#package : 'ZnHostedPharoJS',
	#tag : 'Objects'
}

{ #category : 'private' }
WebWorker class >> appJsFileName [

	<jsLiteralGenerator>
	^ self name , '.js'
]

{ #category : 'private' }
WebWorker class >> createWorker: aClass [

	^ WebWorkerWrapper new: aClass appJsFileName
]

{ #category : 'private' }
WebWorker class >> whenJsReady: aBlock [
	aBlock value
]

{ #category : 'start-stop' }
WebWorker >> _postMessage: aMessage [
<javascript: 'postMessage(aMessage)'>
	
]

{ #category : 'start-stop' }
WebWorker >> onMessage: aMessage [

	SignalingAnswerReceived new.
	self postMessage: aMessage
]

{ #category : 'start-stop' }
WebWorker >> postMessage: aMessage [

	self _postMessage: aMessage asPhxJsonString
]

{ #category : 'start-stop' }
WebWorker >> start [

	onmessage := [ :aMessage |
	             self onMessage:
		             (PhxJsonReader readFromString: aMessage data) ]
]
