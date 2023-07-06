Class {
	#name : #CampingBrowserAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #CampingWebApp
}

{ #category : #'suite parameters' }
CampingBrowserAppTest class >> appClass [
	^ CampingSiteWebApp 
]

{ #category : #accessing }
CampingBrowserAppTest >> setUp [
super setUp
]

{ #category : #accessing }
CampingBrowserAppTest >> test1 [
	self bridge .

	location hash: '#/1'.
	location reload.
	1 second wait.
	self assert: (document querySelector:'.card-title') innerHTML equals: 'Site not found'.
]

{ #category : #accessing }
CampingBrowserAppTest >> test123 [
	self bridge .

	location hash: '#/123'.
	location reload.
	1 second wait.
	self assert: (document querySelector:'.card-title') innerHTML equals: 'Lovely campsite'.
]
