Trait {
	#name : #TGtPhlowActionTooltipBuilder,
	#traits : 'TGtPhlowTooltipBuilder',
	#classTraits : 'TGtPhlowTooltipBuilder classTrait',
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'building tooltip' }
TGtPhlowActionTooltipBuilder >> attachTooltipFor: anElement hostElement: aTargetElement [
	self tooltipBuilder applyOn: anElement hostElement: aTargetElement
]

{ #category : #'api - tooltip' }
TGtPhlowActionTooltipBuilder >> tooltipText [
	"I am a convenience method to easily inspect a tooltip value.
	Please, use corresponding tooltip builder's `apply*` method 
	to apply the tooltip (e.g., to a button)."

	<return: #String or: #BlText>
	^ self tooltipBuilder text
]
