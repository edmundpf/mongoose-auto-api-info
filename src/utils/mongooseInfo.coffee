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
	listFields = []
	encryptFields = []
	primaryKey = null

	# Get Primary Keys, List Fields, Encrypted Fields, and delete non-Mongoose attributes

	for key, attrs of schema
		if attrs.primaryKey? and attrs.primaryKey
			primaryKey = key
			delete schema[key].primaryKey
		if Array.isArray(attrs)
			listFields.push(key)
		if attrs.encrypt? and attrs.encrypt
			encryptFields.push(key)
			delete schema[key].encrypt

	# Mongoose Model and attributes

	return (
		modelName: titleCaseName
		collectionName: snakeCaseName
		primaryKey: primaryKey
		listFields: listFields
		encryptFields: encryptFields
	)
#: Get All Models

getAllModels = () ->
	models = {}
	try
		userModels = requireDirectory(module, '../../../models')
		if Object.keys(userModels).length == 0
			console.log('No models defined, please define models in "models" directory')
	catch error
		console.log('No "models" directory found in root of project, please define models')
	allModels = {
		...authModels,
		...userModels
	}
	for key, val of allModels
		models[camelCase(val.name)] = schemaInfo(val)
	return models

#: Exports

module.exports = getAllModels()