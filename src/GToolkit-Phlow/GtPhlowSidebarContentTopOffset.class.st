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

{ #category : #'api - updating' }
GtPhlowSidebarContentTopOffset >> adjustElement: anElement lenghtWithResizerStrategy: aResizerStrategy [
	"The resizer strategy does not know whether it should change height or width.
	For that reason the adjustment is dispatched to me."

	aResizerStrategy adjustHeightFor: anElement
]

{ #category : #'api - updating' }
GtPhlowSidebarContentTopOffset >> adjustElement: anElement resizerStrategyOnResizerResized: anEvent [
	"The element does not know whether it should store extent x or y value.
	For that reason the adjustment is dispatched to me.
	The given anEvent has extent information."

	anElement beExact: anEvent extent y
]

{ #category : #'api - updating' }
GtPhlowSidebarContentTopOffset >> adjustElementLength: anElement [ 
	"Set element height or width."

	anElement vExact: self length
]

{ #category : #'api - updating' }
GtPhlowSidebarContentTopOffset >> adjustElementOrthogonalLength: anElement [

	anElement hMatchParent
]

{ #category : #'api - updating' }
GtPhlowSidebarContentTopOffset >> adjustResizerElementPosition: aResizerElement [
	"Set the top/bottom/left/right resizer position"

	^ aResizerElement beTop
]

{ #category : #'api - testing' }
GtPhlowSidebarContentTopOffset >> isElementCollapsed: anElement [
	"Return true if an element lenght (height or width) is less or equal to lenght."

	<return: #Boolean>
	^ anElement height <= self length
]

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
