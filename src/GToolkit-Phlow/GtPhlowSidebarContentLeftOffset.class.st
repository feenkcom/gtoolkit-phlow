"
I am {{gtClass:GtPhlowSidebarContentOffset}}.
I am used by {{gtClass:GtPhlowHorizontalSidebarElement}} by calling its {{gtMethod:GtPhlowHorizontalSidebarElement>>#beRight|label=#selector}} method.
1. # Big Distance Example

The following example shows a big distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}}
1. # No Distance Example

The following example shows a zero distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Default Distance Example

The following example shows a default distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : 'GtPhlowSidebarContentLeftOffset',
	#superclass : 'GtPhlowSidebarContentOffset',
	#category : 'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : 'api - accessing' }
GtPhlowSidebarContentLeftOffset >> margin [
	^ BlInsets left: self length
]

{ #category : 'api - accessing' }
GtPhlowSidebarContentLeftOffset >> marginExtra: anExtraLength [
	^ BlInsets left: self length + anExtraLength
]

{ #category : 'private - accessing' }
GtPhlowSidebarContentLeftOffset >> name [
	^ 'Left Offset'
]
