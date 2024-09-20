Class {
	#name : 'WCEFMockModel',
	#superclass : 'Object',
	#instVars : [
		'address'
	],
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'accessing' }
WCEFMockModel >> address [

	^ address
]

{ #category : 'accessing' }
WCEFMockModel >> address: anObject [

	address := anObject
]

{ #category : 'accessing' }
WCEFMockModel >> description [

	^ { (WCStingDescription new
			label: 'Address';
		   getter: #address;
		   setter: #address:) }
]

{ #category : 'accessing' }
WCEFMockModel >> initialize [
	super initialize.
	address := 'Yolo Street'
]
