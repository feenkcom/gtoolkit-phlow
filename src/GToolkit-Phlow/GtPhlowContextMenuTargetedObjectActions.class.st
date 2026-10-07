Class {
	#name : #GtPhlowContextMenuTargetedObjectActions,
	#superclass : #GtPhlowContextMenuCompositeAction,
	#instVars : [
		'target',
		'groupTarget',
		'groupFactory'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuTargetedObjectActions class >> forTarget: aGtPhlowActionTarget [
	^ self new target: aGtPhlowActionTarget
]

{ #category : #'instance creation' }
GtPhlowContextMenuTargetedObjectActions class >> forTarget: aSingleTarget groupTarget: aGroupTarget groupWith: aGroupFactory [
	^ self new
		target: aSingleTarget;
		groupTarget: aGroupTarget;
		groupFactory: aGroupFactory
]

{ #category : #'instance creation' }
GtPhlowContextMenuTargetedObjectActions class >> forTarget: aTarget groupWith: aGroupFactory [
	^ self new
		target: aTarget;
		groupFactory: aGroupFactory
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> groupFactory [
	^ groupFactory
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> groupFactory: aBlock [
	groupFactory := aBlock
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> groupTarget [
	^ groupTarget
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> groupTarget: aGtPhlowActionTarget [
	groupTarget := aGtPhlowActionTarget
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> target [
	^ target
]

{ #category : #accessing }
GtPhlowContextMenuTargetedObjectActions >> target: aGtPhlowActionTarget [
	target := aGtPhlowActionTarget
]

{ #category : #'menu items' }
GtPhlowContextMenuTargetedObjectActions >> toActionOn: anObject index: anIndexSelection element: anElement [
	| actions effectiveTarget effectiveObject |
	actions := OrderedCollection new.
	groupFactory
		ifNil: [
			effectiveTarget := target.
			effectiveObject := anObject ]
		ifNotNil: [
			anObject size = 1
				ifTrue: [
					effectiveTarget := target .
					effectiveObject := anObject first ]
				ifFalse: [
					effectiveTarget := self groupTarget.
					effectiveObject := groupFactory value: anObject ] ].
	effectiveTarget default actionsForObject: effectiveObject do: [ :anAction |
		actions add: anAction ].
	^ actions
]
