"
I wrap a view and add a title to it.
"
Class {
	#name : #GtPhlowLabelledView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'label'
	],
	#category : 'GToolkit-Phlow'
}

{ #category : #accessing }
GtPhlowLabelledView >> asElementDo: aBlock [
	| tab group |
	group := BrTabGroup new.
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new.
		group phlow beView; entity: self.
		tab
			look: BrGlamorousTabLook new invisibleBar;
			label: self label;
			stencil: [ originalElement asScrollableElement ];
			actionsStencil: (self actionsToolbarForElement: group);
			padding: (BlInsets top: 15 right: 0 bottom: 15 left: 10) ].
	group 
		look: (BrMaterialTabGroupLook new headerBackground: (Color fromHexString: #'e0e0e0'));
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
