"
I am an importer taking a model as parameter and creating a model of folders and files from a file reference given to me as parameter in this model.
"
Class {
	#name : #MooseFileStructureImporter,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'factory'
	],
	#category : #'Moose-Importers-Importers'
}

{ #category : #accessing }
MooseFileStructureImporter >> classNamed: aSymbol [
	^ self factory
		entityNamed: aSymbol
		ifAbsent: [ self error: 'This MM does not includes the full concept of files needed by the MooseFileStructureImporter.' ]
]

{ #category : #importing }
MooseFileStructureImporter >> completeImport: folders [
	folders
		do: [ :each | 
			| folder |
			folder := self folderClass named: each filedIn: nil.
			self importContentsInFolderNamed: (FileSystem disk referenceTo: each) filedInFolder: folder.
			self mooseModel add: folder ]
]

{ #category : #accessing }
MooseFileStructureImporter >> factory [
	^ factory ifNil: [ factory := self mooseModel factory ]
]

{ #category : #accessing }
MooseFileStructureImporter >> fileClass [
	^ self classNamed: #File
]

{ #category : #accessing }
MooseFileStructureImporter >> folderClass [
	^ self classNamed: #Folder
]

{ #category : #importing }
MooseFileStructureImporter >> importContentsInFolderNamed: aFolderName filedInFolder: aContainerFolder [
	aFolderName entries
		do: [ :entry |
			entry isFile
				ifTrue: [ self importFileNamed: entry filedInFolder: aContainerFolder ]
				ifFalse: [ self importFolderNamed: entry filedInFolder: aContainerFolder ] ]
]

{ #category : #importing }
MooseFileStructureImporter >> importFileNamed: aFileName filedInFolder: aContainerFolder [
	(self fileClass named: aFileName basename filedIn: aContainerFolder)
		parentFolder: aContainerFolder;
		mooseModel: self mooseModel
]

{ #category : #importing }
MooseFileStructureImporter >> importFolderNamed: aFolderName filedInFolder: aContainerFolder [
	| folder |
	folder := self folderClass named: aFolderName basename filedIn: aContainerFolder.
	folder parentFolder: aContainerFolder.
	self importContentsInFolderNamed: aFolderName reference filedInFolder: folder.
	self mooseModel add: folder
]

{ #category : #accessing }
MooseFileStructureImporter >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MooseFileStructureImporter >> mooseModel: anObject [
	mooseModel := anObject
]
