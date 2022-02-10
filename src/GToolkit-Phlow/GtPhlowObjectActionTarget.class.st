"
I define where a {{gtClass:GtPhlowAction}} should be displayed. 
I am a default target, see {{gtMethod:GtPhlowAction >> #defaultTarget}}.
I determine that actions are supposed to be displayed in a default position, e.g., top-right inspector toolbar: {{gtExample: GtPhlowWithObjectActionTarget>>#itself | noCode=true}}
"
Class {
	#name : #GtPhlowObjectActionTarget,
	#superclass : #GtPhlowActionTarget,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Action Targets'
}
