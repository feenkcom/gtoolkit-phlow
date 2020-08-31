Trait {
	#name : #TGtPhlowViewTooltipBuilder,
	#traits : 'TGtPhlowTooltipBuilder',
	#category : #'GToolkit-Phlow-Tooltip'
}

{ #category : #'building tooltip' }
TGtPhlowViewTooltipBuilder >> attachTooltipFor: anElement [
	self tooltipBuilder applyOn: anElement
]
