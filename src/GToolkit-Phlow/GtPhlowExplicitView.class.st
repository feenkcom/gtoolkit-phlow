"
I represent an explicit view. I am typically used for describing a view of an object.

I decorate a `stencilBuilder` with extra information, such as `title`. The `stencilBuilder` is responsible for creating the contents of the view. The extra information is meant to create the decoration around that content.

For example, a view of an object can be a visualization with the title being Visualization. A typical application is to add this view to a tab group. As we want to be able to create the content lazily, for example because it might be expensive, we need to know the title before the content is created. To this end, we have the title separate from the stencil builder.


"
Class {
	#name : 'GtPhlowExplicitView',
	#superclass : 'GtPhlowViewDecorator',
	#instVars : [
		'stencilBuilder',
		'phlowView'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : 'accessing' }
GtPhlowExplicitView >> asElementDo: aBlock [
	| anElement |
	
	self
		assert: [ stencilBuilder notNil ]
		description: [ 'The stencil should be initialized' ].

	anElement := self 
		performBlock: [ stencilBuilder asElement ] 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].

	self beViewElement: anElement.
	
	^ aBlock value: anElement
]

{ #category : 'private - elements' }
GtPhlowExplicitView >> assignMeAsEntityFor: anElement [
	anElement phlow entity ifNotNil: [ :aPhlowView | 
		phlowView := aPhlowView ].
	anElement phlow updateEntity: self.
]

{ #category : 'accessing' }
GtPhlowExplicitView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : 'accessing' }
GtPhlowExplicitView >> stencilBuilder [
	^ stencilBuilder
]

{ #category : 'api - accessing composite view' }
GtPhlowExplicitView >> views [
	<return: #Array of: #GtPhlowView>
	self 
		assert: [ phlowView isNotNil ] 
		description: [ 'I must not receive #views message when phlowView instance is nil' ].
	^ phlowView views
]
