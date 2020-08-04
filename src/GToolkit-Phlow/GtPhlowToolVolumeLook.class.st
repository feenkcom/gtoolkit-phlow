Class {
	#name : #GtPhlowToolVolumeLook,
	#superclass : #BrInteractiveLook,
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'api - style' }
GtPhlowToolVolumeLook >> detailed: aStyleBlock [
	self
		when: self state detailed
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolVolumeLook >> normal: aStyleBlock [
	self
		when: self state normal
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolVolumeLook >> state [
	^ GtPhlowToolVolumeState
]

{ #category : #'api - style' }
GtPhlowToolVolumeLook >> volume: aNamedVolume style: aStyleBlock [
	self
		when: (self state volume: aNamedVolume)
		style: aStyleBlock
]
