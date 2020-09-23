"
I am a ${class:BrStencil}$.
I create an empty (default) ${class:GtPhlowSidebarElement}$ content, see ${method:GtPhlowSidebarElement>>#defaultContentStencil}$.
!! Example
The following example shows a sidebar with a default empty content (that I generate): ${example:GtPhlowSidebarElementExamples>>#basicHorizontalSidebarElement|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtPhlowSidebarEmptyContentStencil,
	#superclass : #BrStencil,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - instantiation' }
GtPhlowSidebarEmptyContentStencil >> create [
	<return: #Object>

	^ BrFrame new 
		background: BrGlamorousColors neutralBackgroundColor;
		matchParent
]
