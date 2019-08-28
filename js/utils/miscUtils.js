var camelCase, startCase, titleCase;

startCase = require('lodash.startcase');

camelCase = require('lodash.camelcase');

//: Title Case
titleCase = function(text) {
  return startCase(camelCase(text)).replace(/ /g, '');
};

//: Exports
module.exports = {
  titleCase: titleCase
};

//::: End Program :::
