"
I am {{gtClass:GtPhlowSidebarContentOffset}}.
I am used by {{gtClass:GtPhlowVerticalSidebarElement}} by calling its {{gtMethod:GtPhlowVerticalSidebarElement>>#beTop|label=#selector}} method.

1. # Big Distance Example

The following example shows a big distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}}
1. # No Distance Example

The following example shows a zero distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Default Distance Example

The following example shows a default distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowSidebarContentBottomOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentBottomOffset >> margin [
	^ BlInsets bottom: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentBottomOffset >> marginExtra: anExtraLength [
	^ BlInsets bottom: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentBottomOffset >> name [
	^ 'Bottom Offset'
]
