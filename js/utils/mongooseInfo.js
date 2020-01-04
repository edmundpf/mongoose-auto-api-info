var authModels, camelCase, getAllModels, requireDirectory, schemaInfo, snakeCase, titleCase;

requireDirectory = require('require-directory');

titleCase = require('./miscUtils').titleCase;

snakeCase = require('lodash.snakecase');

camelCase = require('lodash.camelcase');

authModels = require('./authModels');

//: Get Schema Info
schemaInfo = function(obj) {
  var allFields, attrs, camelCaseName, encodeFields, encryptFields, key, listFields, name, primaryKey, schema, snakeCaseName, titleCaseName;
  name = obj.name;
  camelCaseName = camelCase(name);
  snakeCaseName = snakeCase(name);
  titleCaseName = titleCase(name);
  schema = obj.schema;
  allFields = [];
  listFields = [];
  encryptFields = [];
  encodeFields = [];
  primaryKey = '_id';
// Get Primary Keys, All Fields, List Fields, Encrypted Fields, and delete non-Mongoose attributes
  for (key in schema) {
    attrs = schema[key];
    if ((attrs.primaryKey != null) && attrs.primaryKey) {
      primaryKey = key;
      delete schema[key].primaryKey;
    }
    if (Array.isArray(attrs)) {
      listFields.push(key);
    }
    if ((attrs.encrypt != null) && attrs.encrypt) {
      encryptFields.push(key);
      delete schema[key].encrypt;
    }
    if ((attrs.encode != null) && attrs.encode) {
      encodeFields.push(key);
      delete schema[key].encode;
    }
    allFields.push(key);
  }
  return {
    // Mongoose Model and attributes
    modelName: titleCaseName,
    collectionName: snakeCaseName,
    primaryKey: primaryKey,
    allFields: allFields,
    listFields: listFields,
    encryptFields: encryptFields,
    encodeFields: encodeFields,
    schema: schema
  };
};

//: Get All Models
getAllModels = function() {
  var allModels, error, key, models, userModels, val;
  models = {};
  try {
    userModels = requireDirectory(module, '../../../../models', {
      recurse: false
    });
    if (Object.keys(userModels).length === 0) {
      console.log('No models defined, please define models in "models" directory');
    }
  } catch (error1) {
    error = error1;
    if ((error.code != null) && error.code === 'ENOENT') {
      console.log('No "models" directory found in root of project, please define models');
    } else {
      console.log('Error parsing models, please check models');
    }
  }
  allModels = {...authModels, ...userModels};
  for (key in allModels) {
    val = allModels[key];
    models[camelCase(val.name)] = schemaInfo(val);
  }
  return models;
};

//: Exports
module.exports = getAllModels();
