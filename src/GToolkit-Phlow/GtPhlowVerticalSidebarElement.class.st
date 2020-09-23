"
I am a ${class:BlElement}$.
I am a sidebar.

I know how to:
- ${method:GtPhlowSidebarElement>>#show|label=#selector}$, 
- ${method:GtPhlowSidebarElement>>#hide|label=#selector}$, 
- ${method:GtPhlowVerticalSidebarElement>>#expand|label=#selector}$, and 
- ${method:GtPhlowVerticalSidebarElement>>#collapse|label=#selector}$ myself.

The content can be defined sending the ${method:GtPhlowSidebarElement>>#contentStencil:|label=#selector}$ message with a ${class:BrStencil}$ as parameter.

Users can:
- set my width using a ${class:BrResizer|label=resizer}$ handler,
- collapse and expand by ${method:GtPhlowSidebarElement>>#onResizerDoubleClick:|label=double clicking}$ on the resizer.
!! Bottom Sidebar Example
The following example shows a sidebar with a label content that you can resize using the handler on the top: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_InContainer|codeExpanded=false|previewExpanded=true}$
!! Top Sidebar Example
The following example shows the sidebar on the top:
${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_InContainer|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtPhlowVerticalSidebarElement,
	#superclass : #GtPhlowSidebarElement,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #location }
GtPhlowVerticalSidebarElement >> beBottom [
	"We want the sidebar at the bottom, 
	therefore the resizer at the top."
	self resizerElement beTop.
	self contentOffset: (GtPhlowSidebarContentOffset top: self contentOffset length)
]

{ #category : #location }
GtPhlowVerticalSidebarElement >> beTop [
	"We want the sidebar at the top, 
	therefore the resizer at the bottom."
	self resizerElement beBottom.
	self contentOffset: (GtPhlowSidebarContentOffset bottom: self contentOffset length)
]

{ #category : #'api - visibility' }
GtPhlowVerticalSidebarElement >> collapse [
	self height: self contentOffset length
]

{ #category : #defaults }
GtPhlowVerticalSidebarElement >> defaultContentOffset [
	^ GtPhlowSidebarContentOffset top: self defaultContentOffsetLength
]

{ #category : #defaults }
GtPhlowVerticalSidebarElement >> defaultResizerLook [
	^ BrGlamorousWithVerticalResizerLook new beTop
]

{ #category : #'api - visibility' }
GtPhlowVerticalSidebarElement >> expand [
	self resizerStrategy adjustHeightFor: self.
]

{ #category : #initialization }
GtPhlowVerticalSidebarElement >> initialize [
	super initialize.
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		hInheritIn: [ :aBlock | self contentElementDo: aBlock ])
]

{ #category : #'private - testing' }
GtPhlowVerticalSidebarElement >> isCollapsed [
	<return: #Boolean>
	^ self height <= self contentOffset length
]

{ #category : #'private - event handling' }
GtPhlowVerticalSidebarElement >> onResizerResized: anEvent [
	self beExact: anEvent extent y
]
