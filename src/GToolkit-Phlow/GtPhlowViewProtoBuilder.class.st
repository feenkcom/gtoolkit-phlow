Class {
	#name : #GtPhlowViewProtoBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #testing }
GtPhlowViewProtoBuilder class >> isAbstract [
	^ self name = #GtPhlowViewProtoBuilder
]

{ #category : #building }
GtPhlowViewProtoBuilder >> build [
	<return: #GtPhlowView>
	^ self subclassResponsibility
]
