"
I am a ${class:BrInteractiveLook}$.
I perform user defined actions on ${class:GtPhlowToolDetailModel}$ changes. Users may use the following methods to configure actions for different states:
- ${method:GtPhlowToolDetailLook>>#normal:|label=#selector}$,
- ${method:GtPhlowToolDetailLook>>#detailed:|label=#selector}$, and
- ${method:GtPhlowToolDetailLook>>#level:style:|label=#selector}$.
!! Example
The following example changes an element background color on information level changes: ${example:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}$ 
"
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
