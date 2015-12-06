Sails = require('sails').Sails

before((done)->

    sails = null
    this.timeout(11000)

    Sails().lift({
        hooks: {
            "pagify": require('../')
            "grunt": false
        },
        models: {
            migrate: 'drop'
        },
        log: {
            level: "error"
        }
    }, (err, _sails)->
        return done(err) if err

        sails = _sails
        done()
    )
)

after((done)->
    Fakeproduct.destroy().then(()->
        return sails.lower(done);
    ).catch done
)
