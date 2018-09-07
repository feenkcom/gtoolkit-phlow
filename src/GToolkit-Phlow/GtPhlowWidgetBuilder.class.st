Class {
	#name : #GtPhlowWidgetBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowWidgetBuilder >> textEditorForText: aBlRopedText [ 
	^ BrEditorElement new
		editor: (BrTextEditor new text: aBlRopedText asRopedText);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent. ]
]
