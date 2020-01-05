requireDirectory = require('require-directory')
titleCase = require('./miscUtils').titleCase
snakeCase = require('lodash.snakecase')
camelCase = require('lodash.camelcase')
authModels = require('./authModels')

#: Get Schema Info

schemaInfo = (obj) ->
	name = obj.name
	camelCaseName = camelCase(name)
	snakeCaseName = snakeCase(name)
	titleCaseName = titleCase(name)
	schema = obj.schema
	allFields = []
	listFields = []
	subDocFields = []
	encryptFields = []
	encodeFields = []
	primaryKey = '_id'

	# Get Primary Keys, All Fields, List Fields, Encrypted Fields, and delete non-Mongoose attributes

	for key, attrs of schema
		isArray = Array.isArray(attrs)
		if attrs.primaryKey? and attrs.primaryKey
			primaryKey = key
			delete schema[key].primaryKey
		if isArray
			listFields.push(key)
		if not isArray and attrs.type.obj?
			subDocFields.push(key)
		if attrs.encrypt? and attrs.encrypt
			encryptFields.push(key)
			delete schema[key].encrypt
		if attrs.encode? and attrs.encode
			encodeFields.push(key)
			delete schema[key].encode
		allFields.push(key)

	# Mongoose Model and attributes

	return (
		modelName: titleCaseName
		collectionName: snakeCaseName
		primaryKey: primaryKey
		allFields: allFields
		listFields: listFields
		subDocFields: subDocFields
		encryptFields: encryptFields
		encodeFields: encodeFields
		schema: schema
	)
#: Get All Models

getAllModels = () ->
	models = {}
	try
		userModels = requireDirectory(
			module,
			'../../../../models',
			recurse: false,
			)
		if Object.keys(userModels).length == 0
			console.log('No models defined, please define models in "models" directory')
	catch error
		if error.code? and error.code == 'ENOENT'
			console.log('No "models" directory found in root of project, please define models')
		else
			console.log('Error parsing models, please check models')
	allModels = {
		...authModels,
		...userModels
	}
	for key, val of allModels
		models[camelCase(val.name)] = schemaInfo(val)
	return models

#: Exports

module.exports = getAllModels()