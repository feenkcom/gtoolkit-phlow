"
I include methods that can be send to ${class:GtPhlowViewDecorator}$ instances and are targeted to ${class:GtPhlowCompositeView}$ instances.

"
Trait {
	#name : #TGtPhlowCompositeViewDecorator,
	#category : #'GToolkit-Phlow-Utilities'
}

{ #category : #'api - accessing composite view' }
TGtPhlowCompositeViewDecorator >> views [
	<return: #Array of: #GtPhlowView>
	^ self explicitRequirement
]
