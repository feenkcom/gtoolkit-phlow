"
I update a view on every {{gtClass:BlElementAddedToSceneGraphEvent}} notification.
I am deprecated class. Using this class may imply undesired behavior, e.g., infinite loops.
- See [](https://github.com/feenkcom/gtoolkit/issues/4403) for more details.
- See the {{gtMethod:GtPhlowForwardViewExamples>>#onAddedToSceneUpdatingView}} example. 
It is better to subscribe to specific announcements using {{gtMethod:GtPhlowView >> updateWhen:in:}}. 

"
Class {
	#name : #GtPhlowUpdateViewOnAddedToScene,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowUpdateViewOnAddedToScene class >> isDeprecated [
	"Using it may imply undesired behavior, e.g., infinite loops.
	See https://github.com/feenkcom/gtoolkit/issues/4403
	See GtPhlowForwardViewExamples>>#onAddedToSceneUpdatingView
	It is better to subscribe to specific announcements."

	^ true
]

{ #category : #subscriptions }
GtPhlowUpdateViewOnAddedToScene >> subscribeOn: aGtPhlowElementContext [
	(aGtPhlowElementContext entity isKindOf: GtPhlowForwarderView)
		ifTrue: [  
			"Ignore added to scene updates for forward views since it creates an infinite update loop.
			See https://github.com/feenkcom/gtoolkit/issues/4403
			See GtPhlowForwardViewExamples>>#onAddedToSceneUpdatingView"
			^ self ].


	aGtPhlowElementContext asyncUpdate
]
