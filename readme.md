# sails-hook-pagify

## DEPENDENCY

- Sails 0.11+

## Installation

```javascript
npm install -S sails-hook-pagify
```

## Configuration (Project-wide)

Create `pagify.js` in the `config` folder. Set `perPage` for the number of records fetched per page. The default is `10`.

```javascript
module.exports.pagify = {
    perPage: 10
}
```
## Method

### pagify(dataKey, options)

**Parameters**

- [**STRING**] `dataKey`
- [**OBJECT**] `options`

**Usage**

Use it as a Model class method:

```javascript
// Get Page 2 from the User Table where
// user.name is like 'colin', sort by `createdAt DESC`
// with pet field populated. 40 results per page.
// Results will be wrapped in `users` key.
User.pagify('users', {
    findQuery: {'name': {'like': '%colin%'}},
    sort: ['createdAt DESC', ''],
    populate: ['pet'],
    page: 2
    perPage: 40 // Overwrite the project-wide settings
});
```

**Response Object**
```json
{
    "users": [{
        /* 40 or less results here */
    }],
    "meta": {
        "paginate": {
            "currentPage": 2,
            "nextPage": null,
            "prevPage": 1,
            "totalPages": 2,
            "totalCount": 80,
            "perPage": 40
        }
    }
}
```
