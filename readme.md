# sails-hook-pagify

**Who need this?**
- API-driven server that needs to support mobile application features like infinite list loading
- Any page that needs metadata (*next, prev, currentpage, totalCount etc..*) to constuct the pagination UI.

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
    - [**OBJECT**] `findQuery` - Waterline query object. Default is {}.
    - [**ARRAY**] `sort` - Default is [].
    - [**ARRAY**] `populate`- Default is [].
    - [**INTEGER**] `page` - Current page number. Default is 1.
    - [**INTEGER**] `perPage` - Number of records per page. Default is 10.

**Usage**

Use it as a Model class method:

```javascript
// Get Page 2 from the User Model where
// user.name is like 'colin', sort by `createdAt DESC`
// with pet field populated. 40 results per page.
// Results will be wrapped in `users` key.
User.pagify('users', {
    findQuery: {'name': {'like': '%colin%'}},
    sort: ['createdAt DESC'],
    populate: ['pet'],
    page: 2
    perPage: 40 // Overwrite the project-wide settings
}).then(function(data){
    // See Response Object Below
}).catch(function(err){
    // err.Errors contains the error messages
});
```

As you can see, `pagify` is a promise-returning method.

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

## Contributors:
- [jiewmeng](https://github.com/jiewmeng)
- [colintoh](https://github.com/colintoh)

## MIT License
Copyright (c) 2015 colintoh and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


