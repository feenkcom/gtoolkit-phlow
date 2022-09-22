"
I wrap a view and add a title to it.


"
Class {
	#name : #GtPhlowLabelledView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowLabelledView >> asElementDo: aBlock [
	| tab group |
	group := BrTabGroup new.
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new.
		tab phlow beView; entity: self.
		tab
			aptitude: BrGlamorousTabWithoutBarAptitude;
			label: self newLabel;
			stencil: [ 
				originalElement phlow beViewContent.
				originalElement asScrollableElement ];
			toolbarStencil: [ self actionsToolbarForElement: tab ];
			padding: (BlInsets top: 15 right: 0 bottom: 15 left: 10) ].
	group 
		aptitude: (BrGlamorousTabGroupAptitude new headerBackground: (BrGlamorousColors defaultHeaderBackgroundColor));
		addTab: tab;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	self beViewElement: group.
	^ aBlock value: group
]

{ #category : #defaults }
GtPhlowLabelledView >> defaultUpdateDefinitions [
	^ super defaultUpdateDefinitions copyWith: GtPhlowUpdateLabeledOnClassAndSuperClassChange
]

{ #category : #accessing }
GtPhlowLabelledView >> label [
	^ label
]

{ #category : #accessing }
GtPhlowLabelledView >> label: anObject [
	label := anObject
]

{ #category : #'instance creation' }
GtPhlowLabelledView >> newLabel [
	<return: #BlRunRopedText or: #String>
	^ self label value
]
