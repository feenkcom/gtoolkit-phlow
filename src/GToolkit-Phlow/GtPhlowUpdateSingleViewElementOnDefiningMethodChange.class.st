Class {
	#name : #GtPhlowUpdateSingleViewElementOnDefiningMethodChange,
	#superclass : #GtPhlowUpdateDefinition,
	#instVars : [
		'listeners'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowUpdateSingleViewElementOnDefiningMethodChange >> installOn: anElement [
	| aListener |
	super installOn: anElement.
	aListener := GtPhlowChangeMethodSystemAnnouncerListener
			installOnSingleElement: anElement.
	aListener ifNil: [ ^ self ].
	listeners := listeners
			ifNil: [ WeakArray with: aListener ]
			ifNotNil: [ :aCollection | 
				WeakArray
					new: aCollection size + 1
					streamContents: [ :aStream | 
						aStream
							nextPutAll: aCollection;
							nextPut: aListener ] ]
]

{ #category : #testing }
GtPhlowUpdateSingleViewElementOnDefiningMethodChange >> isUpdateOnMethodChanged [
	^ true
]

{ #category : #subscriptions }
GtPhlowUpdateSingleViewElementOnDefiningMethodChange >> uninstall [
	super uninstall.
	listeners ifNotNil: [ :aCollection | aCollection do: #unsubscribeFromSystem ].
	listeners := nil.
]
