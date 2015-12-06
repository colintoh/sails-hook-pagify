assert = require('chai').assert
path = require('path')
libPath = path.join(__dirname, '../lib')

validateOptions = require(path.join(libPath, 'validateOptions'))

describe 'Validate Parameters', ()->

    it 'undefined parameter', ()->
        error = validateOptions()

        assert.lengthOf error, 1
        assert.equal error[0], 'options parameter is undefined'

    it 'empty object', ()->
        error = validateOptions({})
        assert.lengthOf error, 5
        assert.equal error[0], '"findQuery" should be an object'
        assert.equal error[1], '"sort" should be an array'
        assert.equal error[2], '"populate" should be an array'
        assert.equal error[3], '"page" should be a number'
        assert.equal error[4], '"perPage" should be a number'

    it 'object with invalid types', ()->

        error = validateOptions({
            findQuery: '1234',
            sort: "123",
            populate: "123",
            page: 'abc',
            perPage: 'abc'
        })

        assert.lengthOf error, 5

    describe 'pagify with invalid parameters', ()->

        it 'check error response', (done)->
            Fakeproduct.pagify('products', {
                findQuery: '1234',
                sort: "123",
                populate: "123",
                page: 'abc',
                perPage: 'abc'
            }).then((data)->
                done(new Error('Should not pass.'))
            ).catch((err)->
                assert.equal err.message, 'Invalid parameter(s)'
                assert.ok (err.Errors.indexOf('"findQuery" should be an object') >= 0)
                assert.ok (err.Errors.indexOf('"sort" should be an array') >= 0)
                assert.ok (err.Errors.indexOf('"populate" should be an array') >= 0)
                assert.ok (err.Errors.indexOf('"page" should be a number') >= 0)
                assert.ok (err.Errors.indexOf('"perPage" should be a number') >= 0)

                done()
            ).catch done



