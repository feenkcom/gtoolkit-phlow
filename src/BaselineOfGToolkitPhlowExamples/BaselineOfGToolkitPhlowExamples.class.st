Class {
	#name : #BaselineOfGToolkitPhlowExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlowExamples
}

{ #category : #baseline }
BaselineOfGToolkitPhlowExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.8.1597/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.102/src' ].

		spec package: 'GToolkit-Phlow-Examples' with: [
			spec requires: #(#GToolkitPhlow #GToolkitExamplesEngine) ].
	]
]
