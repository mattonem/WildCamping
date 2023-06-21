Class {
	#name : #BaselineOfCamping,
	#superclass : #BaselineOf,
	#category : #BaselineOfCamping
}

{ #category : #baselines }
BaselineOfCamping >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'PharoJS'
			with: [ spec repository: 'github://PharoJS/PharoJS:pharo10' ].
		spec baseline: 'Seaside3' with: [ 
			spec
				loads: #( 'Seaside-Canvas' );
				repository: 'github://SeasideSt/Seaside:master/repository' ].
		spec package: #ZnHostedPharoJS ]
]
