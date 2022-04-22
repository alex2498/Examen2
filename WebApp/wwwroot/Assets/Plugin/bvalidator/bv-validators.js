"use strict";
var bvAddValidators;
bvAddValidators = function (NombreAtribute, validateFun) {
    eval("$.fn.bootstrapValidator.validators.".concat(NombreAtribute, "={validate:function (validator, $field, options) { return  validateFun(validator,$field,options); } };"));
};
//# sourceMappingURL=bv-validators.js.map