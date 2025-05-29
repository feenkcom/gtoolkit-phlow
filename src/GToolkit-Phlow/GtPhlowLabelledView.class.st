"
I wrap a view and add a title to it.


"
Class {
	#name : #GtPhlowLabelledView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'labelComputation'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowLabelledView >> asElementDo: aBlock [
	| tab group |
	group := BrTabGroup new.
	group id: GtPhlowLabelledViewElementId.
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new.
		tab phlow beViewTitle; entity: self.
		tab
			aptitude: BrGlamorousTabWithoutBarAptitude;
			label: self newLabel;
			stencil: [ 
				originalElement phlow beViewContent.
				originalElement asScrollableElement ];
			toolbarStencil: [ self actionsToolbarForElement: tab ];
			padding: (BlInsets top: 15 right: 0 bottom: 15 left: 10) ].
	group 
		aptitude: (BrGlamorousTabGroupAptitude new headerBackground: (BlTheme default header defaultBackground));
		addTab: tab;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	self beViewElement: group.
	^ aBlock value: group
]

{ #category : #defaults }
GtPhlowLabelledView >> defaultUpdateDefinitions [
	^ super defaultUpdateDefinitions copyWith: GtPhlowUpdateLabelledViewTitleOnClassChange
]

{ #category : #'initialization ' }
GtPhlowLabelledView >> initialize [
	super initialize.
	labelComputation := [ self buildContext isBuildContext 
		ifTrue: [ self buildContext object gtInspectorTitleString ]
		ifFalse: [ 'Labelled view' ] ]
]

{ #category : #accessing }
GtPhlowLabelledView >> label [
	^ labelComputation
]

{ #category : #accessing }
GtPhlowLabelledView >> label: anObject [
	labelComputation := anObject
]

{ #category : #'instance creation' }
GtPhlowLabelledView >> newLabel [
	<return: #BlRunRopedText or: #String>
	^ [ self label value ]
		on: Error
		do: [ :anException | 
			anException printString asRopedText
				foreground: BrGlamorousColors linkWithErrorColor ]
]
