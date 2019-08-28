startCase = require('lodash.startcase')
camelCase = require('lodash.camelcase')

#: Title Case

titleCase = (text) ->
	return startCase(camelCase(text)).replace(/ /g, '')

#: Exports

module.exports =
	titleCase: titleCase

#::: End Program :::