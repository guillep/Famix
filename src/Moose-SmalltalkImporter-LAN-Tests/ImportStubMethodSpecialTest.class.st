"
A special ctest class for importing stub methods, because by defualt they are not imported and therefore, we need to have a special setup here
"
Class {
	#name : #ImportStubMethodSpecialTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Moose-SmalltalkImporter-LAN-Tests'
}

{ #category : #running }
ImportStubMethodSpecialTest >> setUp [

	| importingTask |
	super setUp.
	importingTask := FamixStPharoImporterTask new
		                 model: FamixStModel new;
		                 addFromPackageNamed: #'Moose-TestResources-LAN';
		                 yourself.
	importingTask importingContext importStubMethod.
	importingTask run.
	model := importingTask model
]

{ #category : #tests }
ImportStubMethodSpecialTest >> testStubMethodCreation [
	self denyEmpty: (model allMethods select: #isStub).
	self denyEmpty: model allModelMethods
]
