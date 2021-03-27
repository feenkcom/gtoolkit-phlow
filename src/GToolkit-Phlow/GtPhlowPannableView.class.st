Class {
	#name : #GtPhlowPannableView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'stencilBuilder',
		'element'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowPannableView >> asElementDo: aBlock [
	self assert: stencilBuilder notNil description: 'The stencil should be initialized'.
	element := [ stencilBuilder asElement asPannableElement ] 
		on: Error 
		do: [ :anError | 
			(self phlowErrorViewWithException: anError)
				asElementDo: [ :errorElement | errorElement ] ].
	element phlow beView; entity: self.
	^ aBlock value: element.
]

{ #category : #initialization }
GtPhlowPannableView >> initialize [
	super initialize.
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomin asElement ;
			action: [ element zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomout asElement ;
			action: [ element zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomtofit asElement ;
			action: [ element zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons actualsize asElement;
			action: [ element zoomToActualSize ] ]
]

{ #category : #accessing }
GtPhlowPannableView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #accessing }
GtPhlowPannableView >> stencilBuilder [
	^ stencilBuilder
]
