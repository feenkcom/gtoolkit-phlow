Class {
	#name : #BaselineOfGToolkitPhlowExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlowExamples
}

{ #category : #accessing }
BaselineOfGToolkitPhlowExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:main/src' ].
		spec package: 'GToolkit-Phlow-Examples' with: [
				spec requires: #('GToolkitPhlow' 'GToolkitExamplesEngine'). ]. ].

]
