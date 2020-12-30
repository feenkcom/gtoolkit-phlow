"
I exemplify ${class:GtPhlowTitleNotifier|expanded=true|show=#gtSubclassesFor:|height=130}$ subclasses.
"
Class {
	#name : #GtPhlowTitleNotifierExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : #'examples - element' }
GtPhlowTitleNotifierExamples >> element [
	<gtExample>
	^ BrButton new
		look: BrGlamorousButtonWithIconAndLabelLook;
		when: GtPhlowChangeTitleWish do: [ :aWish | 
			aWish iconDo: [ :aStencil | 
				aWish currentTarget icon: aStencil ].
			aWish labelDo: [ :aLabel | 
				aWish currentTarget label: aLabel ] ]
]
