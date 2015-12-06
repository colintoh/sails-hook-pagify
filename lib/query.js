module.exports = {
    find: function(Table, options){
        // query the table
        var query = Table.find(options.findQuery);

        options.sort.forEach(function(sortQuery){
            query = query.sort(sortQuery);
        })

        // populate fields if required
        options.populate.forEach(function(field) {
            query = query.populate(field);
        });

        // do pagination
        query = query.paginate({
            limit: options.perPage,
            page: options.page
        });

        return query;
    },

    count: function(Table, findQuery){
        return Table.count(findQuery);
    }
}
