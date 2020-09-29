Class {
	#name : #GtPhlowToolDetailLook,
	#superclass : #BrInteractiveLook,
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'api - style' }
GtPhlowToolDetailLook >> detailed: aStyleBlock [
	self
		when: self state detailed
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailLook >> level: aNamedVolume style: aStyleBlock [
	self
		when: (self state level: aNamedVolume)
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailLook >> normal: aStyleBlock [
	self
		when: self state normal
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailLook >> state [
	^ GtPhlowToolDetailState
]
