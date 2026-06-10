"
I exemplify {{gtClass:GtPhlowTitleNotifier|expanded=true|show=#gtSubclassesFor:|height=130}} subclasses.


"
Class {
	#name : #GtPhlowTitleNotifierExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #'examples - element' }
GtPhlowTitleNotifierExamples >> element [
	<gtExample>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
		when: GtPhlowChangeTitleWish do: [ :aWish | 
			self handleChangeTitleWish:aWish ]
]

{ #category : #'event handling' }
GtPhlowTitleNotifierExamples >> handleChangeTitleWish: aWish [
	aWish iconDo: [ :aStencil |
			aWish currentTarget icon: (aWish 
				buildElementWithToolIcon: aStencil) ].
			
	aWish labelDo: [ :aLabel | 
			aWish currentTarget label: aLabel ]
]
