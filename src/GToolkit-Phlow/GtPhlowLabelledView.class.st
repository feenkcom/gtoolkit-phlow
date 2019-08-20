"
I wrap a view and add a title to it.
"
Class {
	#name : #GtPhlowLabelledView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowLabelledView >> asElementDo: aBlock [
	| tab group |
	group := BrTabGroup new.
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new.
		tab phlow beView; entity: self.
		tab
			look: BrGlamorousTabWithoutBarLook;
			label: self label;
			stencil: [ originalElement asScrollableElement ];
			toolbarStencil: (self actionsToolbarForElement: tab);
			padding: (BlInsets top: 15 right: 0 bottom: 15 left: 10) ].
	group 
		look: (BrGlamorousTabGroupLook new headerBackground: (Color fromHexString: #'e0e0e0'));
		addTab: tab;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	^ aBlock value: group
]

{ #category : #accessing }
GtPhlowLabelledView >> label [
	^ label
]

{ #category : #accessing }
GtPhlowLabelledView >> label: anObject [
	label := anObject
]
