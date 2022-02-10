"
I define where a {{gtClass:GtPhlowAction}} should be displayed.
I am a composite action target that defines several action targets for one action.
Individual {{gtClass:GtPhlowAction}} instances, can be composed using the {{gtMethod: GtPhlowActionTarget >> #, | label=#selector}} (comma) method.

In the following example, we can see the same button in two positions: {{gtExample: GtPhlowWithCompositeActionTarget >> #itself | noCode=true}}

See, my definition in {{gtMethod: GtPhlowWithCompositeActionTarget >> #gtDemoActionWithTargetFor: | expanded=true}} 
"
Class {
	#name : #GtPhlowCompositeActionTarget,
	#superclass : #GtPhlowActionTarget,
	#instVars : [
		'targets'
	],
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #'gt - extensions' }
GtPhlowCompositeActionTarget >> gtTargetsFor: aView [

	<gtView>
	^ aView list
		  title: 'Targets';
		  items: [ self targets ifNil: [ #(  ) ] ]
]

{ #category : #initialization }
GtPhlowCompositeActionTarget >> initialize [

	super initialize.

	targets := #(  )
]

{ #category : #testing }
GtPhlowCompositeActionTarget >> isForViewDefinedIn: aSymbol [

	^ self targets anySatisfy: [ :eachTarget | 
		  eachTarget isForViewDefinedIn: aSymbol ]
]

{ #category : #accessing }
GtPhlowCompositeActionTarget >> targets [

	^ targets
]

{ #category : #accessing }
GtPhlowCompositeActionTarget >> targets: anObject [

	targets := anObject
]

{ #category : #enumerating }
GtPhlowCompositeActionTarget >> targetsDo: aBlock [

	 "Iterate over all leaf action targets. For example, 
	 I do not evaluate aBlock for composite targets."
	 
	 targets do: [ :eachTarget | eachTarget targetsDo: aBlock ]
]
