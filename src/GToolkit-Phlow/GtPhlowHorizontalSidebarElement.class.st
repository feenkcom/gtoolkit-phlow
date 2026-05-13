"
I am a {{gtClass:BlElement}}.
I am a sidebar.

I know how to:
- {{gtMethod:GtPhlowSidebarElement>>#show|label=#selector}}, 
- {{gtMethod:GtPhlowSidebarElement>>#hide|label=#selector}}, 
- {{gtMethod:GtPhlowHorizontalSidebarElement>>#expand|label=#selector}}, and 
- {{gtMethod:GtPhlowHorizontalSidebarElement>>#collapse|label=#selector}} myself.

The content can be defined sending the {{gtMethod:GtPhlowSidebarElement>>#contentStencil:|label=#selector}} message with a {{gtClass:BrStencil}} as parameter.

Users can:
- set my width using a {{gtClass:BrResizer|label=resizer}} handler,
- collapse and expand by {{gtMethod:GtPhlowSidebarElement>>#onResizerDoubleClick:|label=double clicking}} on the resizer.
1. # Left Sidebar Example

The following example shows a sidebar with a label content that you can resize using the handler on the right: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Right Sidebar Example

The following example shows the sidebar on the right side:
{{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowHorizontalSidebarElement,
	#superclass : #GtPhlowSidebarElement,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #defaults }
GtPhlowHorizontalSidebarElement >> defaultContentOffset [
	^ GtPhlowSidebarContentOffset right: self defaultContentOffsetLength
]

{ #category : #defaults }
GtPhlowHorizontalSidebarElement >> defaultResizerLook [
	^ BrGlamorousWithHorizontalResizerAptitude new
]

{ #category : #initialization }
GtPhlowHorizontalSidebarElement >> initialize [
	super initialize.
	
	"We do not want to propagate detail states to children."
	contentElement states addState: GtPhlowToolDetailState normal.
	contentElement states addState: GtPhlowToolDetailPositionState left.
]
