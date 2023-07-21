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
			with: [ spec repository: 'github://PharoJS/PharoJS' ].
		spec baseline: 'Seaside3' with: [
			spec
				loads: #( 'Seaside-Canvas' );
				repository: 'github://SeasideSt/Seaside:master/repository' ].
		spec package: #Leafletjs with: [ spec requires: 'PharoJS' ].
		spec package: #ZnHostedPharoJS with: [
			spec
				requires: #Leafletjs;
				requires: 'PharoJS';
				requires: 'Seaside3' ].
		spec package: #'ZnHostedPharoJS-Tests' with: [
			spec
				requires: #ZnHostedPharoJS;
				requires: #Leafletjs;
				requires: 'PharoJS';
				requires: 'Seaside3' ] ]
]
