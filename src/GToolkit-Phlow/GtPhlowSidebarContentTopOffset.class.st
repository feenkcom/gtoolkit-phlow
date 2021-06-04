"
I am {{gtClass:GtPhlowSidebarContentOffset}}.
I am used by {{gtClass:GtPhlowVerticalSidebarElement}} by calling its {{gtMethod:GtPhlowVerticalSidebarElement>>#beBottom|label=#selector}} method.

1. # Big Distance Example

The following example shows a big distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}}
1. # No Distance Example

The following example shows a zero distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Default Distance Example

The following example shows a default distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowSidebarContentTopOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentTopOffset >> margin [
	^ BlInsets top: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentTopOffset >> marginExtra: anExtraLength [
	^ BlInsets top: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentTopOffset >> name [
	^ 'Top Offset'
]
