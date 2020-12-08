"
I am an abstract class.
I provide basic ${class:TBrLayoutResizable}$ methods.
See my ${class:GtPhlowElement|expanded|show=#gtSubclassesFor:}$ for concrete implementations:
"
Class {
	#name : #GtPhlowElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #initialization }
GtPhlowElement >> initialize [
	super initialize.
	
	self matchParent.
]
