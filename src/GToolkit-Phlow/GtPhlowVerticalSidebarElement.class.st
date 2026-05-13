"
I am a {{gtClass:BlElement}}.
I am a sidebar.

I know how to:
- {{gtMethod:GtPhlowSidebarElement>>#show|label=#selector}}, 
- {{gtMethod:GtPhlowSidebarElement>>#hide|label=#selector}}, 
- {{gtMethod:GtPhlowVerticalSidebarElement>>#expand|label=#selector}}, and 
- {{gtMethod:GtPhlowVerticalSidebarElement>>#collapse|label=#selector}} myself.

The content can be defined sending the {{gtMethod:GtPhlowSidebarElement>>#contentStencil:|label=#selector}} message with a {{gtClass:BrStencil}} as parameter.

Users can:
- set my width using a {{gtClass:BrResizer|label=resizer}} handler,
- collapse and expand by {{gtMethod:GtPhlowSidebarElement>>#onResizerDoubleClick:|label=double clicking}} on the resizer.
1. # Bottom Sidebar Example

The following example shows a sidebar with a label content that you can resize using the handler on the top: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Top Sidebar Example

The following example shows the sidebar on the top:
{{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowVerticalSidebarElement,
	#superclass : #GtPhlowSidebarElement,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #defaults }
GtPhlowVerticalSidebarElement >> defaultContentOffset [
	^ GtPhlowSidebarContentOffset top: self defaultContentOffsetLength
]

{ #category : #defaults }
GtPhlowVerticalSidebarElement >> defaultResizerLook [
	^ BrGlamorousWithVerticalResizerAptitude new beTop
]
