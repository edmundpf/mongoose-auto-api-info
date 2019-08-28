# Mongoose Api
[![Build Status](https://travis-ci.org/edmundpf/mongoose-auto-api-info.svg?branch=master)](https://travis-ci.org/edmundpf/mongoose-auto-api-info)
[![npm version](https://badge.fury.io/js/mongoose-auto-api.info.svg)](https://badge.fury.io/js/mongoose-auto-api.info)
> Automatic Mongoose REST API - Module to get schema info ☕

## Install
* `npm i -S mongoose-auto-api.info`

## Model Setup
* Create *"models"* folder in root directory of project
* Add a model by adding a file for each model to the directory as follows
``` javascript
module.exports = {
	name: 'customer',
	schema: {
		name: {
			type: String,
			unique: true,
			required: true,
			primaryKey: true,
		},
		email: {
			type: String,
			unique: true,
			required: true,
		},
		products: [{
			type: String
		}]
	},
}
```
* Requires *name* and *schema*
	* Schema definitions are the same as normal mongoose definitions with a few additions
		* primaryKey - unique field used to find documents from the API
		* encrypted - if true field will be bcrypt encrypted, useful for passwords

## Usage
``` javascript
info = require('mongoose-auto-api.info')
```
