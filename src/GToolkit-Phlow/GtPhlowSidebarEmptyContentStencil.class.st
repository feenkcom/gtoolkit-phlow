"
I am a {{gtClass:BrStencil}}.
I create an empty (default) {{gtClass:GtPhlowSidebarElement}} content, see {{gtMethod:GtPhlowSidebarElement>>#defaultContentStencil}}.
1. # Example

The following example shows a sidebar with a default empty content (that I generate): {{gtExample:GtPhlowSidebarElementExamples>>#basicHorizontalSidebarElement|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : 'GtPhlowSidebarEmptyContentStencil',
	#superclass : 'BrStencil',
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : 'api - instantiation' }
GtPhlowSidebarEmptyContentStencil >> create [
	<return: #Object>

	^ BrFrame new 
		background: BrGlamorousColors neutralBackgroundColor;
		matchParent
]
