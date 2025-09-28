Class {
	#name : #GtPhlowCanvassableView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'stencilBuilder',
		'element',
		'zoomLevel'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowCanvassableView >> asElementDo: aBlock [
	self
		assert: stencilBuilder notNil
		description: 'The stencil should be initialized'.
	element := [ stencilBuilder asElement asCanvassableElement
			zoomLevel: self zoomLevel ]
			on: Error
			do: [ :anError | 
				(self phlowErrorViewWithException: anError)
					asElementDo: [ :errorElement | errorElement ] ].
	element phlow
		beViewContent;
		entity: self.
	^ aBlock value: element
]

{ #category : #initialization }
GtPhlowCanvassableView >> initialize [
	super initialize.
	zoomLevel := 1.
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomin asElement;
				action: [ element zoomIn ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomout asElement;
				action: [ element zoomOut ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomtofit asElement;
				action: [ element zoomToFit ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons actualsize asElement;
				action: [ element zoomToActualSize ] ]
]

{ #category : #accessing }
GtPhlowCanvassableView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #accessing }
GtPhlowCanvassableView >> stencilBuilder [
	^ stencilBuilder
]

{ #category : #accessing }
GtPhlowCanvassableView >> zoomLevel [
	^ zoomLevel
]

{ #category : #accessing }
GtPhlowCanvassableView >> zoomLevel: aNumber [
	zoomLevel := aNumber
]
