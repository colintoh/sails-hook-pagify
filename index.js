'use strict';

//dependencies
var path = require('path');
var libPath = path.join(__dirname, 'lib');
var pagify = require(path.join(libPath, 'pagify'));

module.exports = function(sails){

    function patch(context){
        _(sails.models).forEach(function(model){

            // Add pagify method to all models. Ignoring associative tables
            if(model.globalId){
                pagify(model, context);
            }
        })
    }

    return {

        defaults: {
            __configKey__: {
                perPage: 10
            }
        },

        initialize: function(next){

            var waitEvents = [];
            if(sails.hooks.orm){
                waitEvents.push('hook:orm:loaded');
            }

            if (sails.hooks.pubsub) {
                waitEvents.push('hook:pubsub:loaded');
            }

            sails.after(waitEvents, function(){
                patch(this);
                next();
            }.bind(this))
        }
    }
}
