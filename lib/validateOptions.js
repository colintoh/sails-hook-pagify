module.exports = function(options){
    var errors = [];

    if(!options) return ['options parameter is undefined'];

    if (typeof options.findQuery !== 'object') {
        errors.push('"findQuery" should be an object');
    }

    if (!(options.sort instanceof Array)) {
        errors.push('"sort" should be an array');
    }

    if (!(options.populate instanceof Array)) {
        errors.push('"populate" should be an array');
    }

    if (typeof options.page !== 'number') {
        errors.push('"page" should be a number');
    }

    if (typeof options.perPage !== 'number') {
        errors.push('"perPage" should be a number');
    }

    return errors;
}
