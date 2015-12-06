module.exports = {
    attributes: {
        title: {
            required: true,
            type: 'string'
        },
        daysOnShelf: {
            type: 'integer',
            defaultsTo: 0
        },
        company: {
            type: 'string'
        }

    }
}
