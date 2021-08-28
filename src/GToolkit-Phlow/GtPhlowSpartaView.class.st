"
I let users define views with custom rendering

```
view := GtPhlowSpartaView new.
view hMatchParent.
view height: 500.
view rendering: [ :aCanvas :anElement |
	aCanvas fill
		paint: Color red;
		path: anElement bounds asRectangle;
		draw ].
view asElementDo: #yourself
```


"
Class {
	#name : 'GtPhlowSpartaView',
	#superclass : 'GtPhlowViewDecorator',
	#instVars : [
		'renderingStencilBuilder',
		'embellisher',
		'horizontalResizer',
		'verticalResizer'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : 'converting' }
GtPhlowSpartaView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	| aSpartaElement |
	
	aSpartaElement := BlSpartaElement new.
	aSpartaElement constraintsDo: [ :c |
		c horizontal resizer: horizontalResizer.
		c vertical resizer: verticalResizer ].
	aSpartaElement rendering: renderingStencilBuilder.
	embellisher value: aSpartaElement.

	aSpartaElement phlow 
		beView; 
		entity: self.

	^ aBlock value: aSpartaElement
]

{ #category : 'accessing' }
GtPhlowSpartaView >> embellisher: aValuable [
	embellisher := aValuable
]

{ #category : 'accessing' }
GtPhlowSpartaView >> extent: anExtent [
	self width: anExtent x.
	self height: anExtent y
]

{ #category : 'accessing' }
GtPhlowSpartaView >> hMatchParent [
	horizontalResizer := BlLayoutResizer matchParent
]

{ #category : 'accessing' }
GtPhlowSpartaView >> height: aNumber [
	verticalResizer := BlLayoutResizer exact: aNumber asFloat
]

{ #category : 'initialization' }
GtPhlowSpartaView >> initialize [
	super initialize.
	
	embellisher := [ :aSpartaElement | ].
	renderingStencilBuilder := [ :aSpartaCanvas :anElement | ].
	self matchParent
]

{ #category : 'accessing' }
GtPhlowSpartaView >> matchParent [
	self hMatchParent; vMatchParent
]

{ #category : 'accessing' }
GtPhlowSpartaView >> rendering: aValuable [
	renderingStencilBuilder := aValuable
]

{ #category : 'accessing' }
GtPhlowSpartaView >> vMatchParent [
	verticalResizer := BlLayoutResizer matchParent
]

{ #category : 'accessing' }
GtPhlowSpartaView >> width: aNumber [
	horizontalResizer := BlLayoutResizer exact: aNumber asFloat
]
