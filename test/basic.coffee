Q = require('q')
faker = require('faker')
assert = require('chai').assert
expect = require('chai').expect


describe 'Get product via pagify', ()->

    describe 'With no products created', ()->

        it('Get page 1', (done)->
            Fakeproduct.pagify('products', {}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 0

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 0
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 2', (done)->
            Fakeproduct.pagify('products', {page: 2}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 0

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 2
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, 1
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 0
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 1 with 20 per page', (done)->
            Fakeproduct.pagify('products', {page: 1, perPage: 20}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 0

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 0
                assert.equal obj.meta.paginate.perPage, 20
                done()
            ).catch done
        )


    describe 'With 20 products created', ()->

        # SETUP
        # Create 20 product records
        # 18 records from faker, 2 custom record
        before((done)->
            promiseArr = []
            for i in [0...18]
                promiseArr.push Fakeproduct.create({title: faker.commerce.productName()})

            promiseArr.push Fakeproduct.create({title: 'pagify-branded 1', daysOnShelf: 5, company: '2359media'})

            Q.all(promiseArr).then((products)->
                assert.lengthOf products, 19
                return Fakeproduct.create({title: 'pagify-branded 2', daysOnShelf: 5, company: '2359media'})
            )
            .then(done.bind(null, null))
            .catch done

        )

        after((done)->
            Fakeproduct.destroy().then(done.bind(null, null)).catch done
        )

        it('Get page 1', (done)->
            Fakeproduct.pagify('products').then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 10

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, 2
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 2
                assert.equal obj.meta.paginate.totalCount, 20
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 2', (done)->
            Fakeproduct.pagify('products', {page: 2}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 10

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 2
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, 1
                assert.equal obj.meta.paginate.totalPages, 2
                assert.equal obj.meta.paginate.totalCount, 20
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 1 with 20 per page', (done)->
            Fakeproduct.pagify('products', {page: 1, perPage: 20}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 20

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 20
                assert.equal obj.meta.paginate.perPage, 20
                done()
            ).catch done
        )

        it('Get page 3 with 20 per page', (done)->
            Fakeproduct.pagify('products', {page: 3, perPage: 20}).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                assert.lengthOf obj.products, 0

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 3
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, 2
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 20
                assert.equal obj.meta.paginate.perPage, 20
                done()
            ).catch done
        )

        it('Get page 1 with products title that are LIKE "pagify-branded" and sorted by "createdAt ASC"', (done)->
            Fakeproduct.pagify('products',
                findQuery:
                    title:
                        "like": "pagify-branded%"
                sort: ["createdAt ASC"]
            ).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                # Check products
                assert.lengthOf obj.products, 2
                assert.equal obj.products[0].title, 'pagify-branded 1'
                assert.equal obj.products[1].title, 'pagify-branded 2'

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 2
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 1 with products title that are LIKE "pagify-branded" and sorted by "createdAt DESC"', (done)->
            Fakeproduct.pagify('products',
                findQuery:
                    title:
                        "like": "pagify-branded%"
                sort: ["createdAt DESC"]
            ).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                # Check products
                assert.lengthOf obj.products, 2
                assert.equal obj.products[0].title, 'pagify-branded 2'
                assert.equal obj.products[1].title, 'pagify-branded 1'

                # Check meta body
                expect(obj.meta).to.have.key('paginate')
                expect(obj.meta.paginate).to.have.all.keys('currentPage', 'nextPage', 'prevPage', 'totalPages', 'totalCount', 'perPage')
                assert.equal obj.meta.paginate.currentPage, 1
                assert.equal obj.meta.paginate.nextPage, null
                assert.equal obj.meta.paginate.prevPage, null
                assert.equal obj.meta.paginate.totalPages, 1
                assert.equal obj.meta.paginate.totalCount, 2
                assert.equal obj.meta.paginate.perPage, 10
                done()
            ).catch done
        )

        it('Get page 1 with products that has daysOnShelf = 5 and sorted by "title ASC, createdAt ASC"', (done)->
            Fakeproduct.pagify('products',
                findQuery:
                    daysOnShelf: 5
                sort: ["company ASC", "createdAt ASC"]
            ).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                # Check products
                assert.lengthOf obj.products, 2
                assert.equal obj.products[0].title, 'pagify-branded 1'
                assert.equal obj.products[1].title, 'pagify-branded 2'

                done()
            ).catch done
        )

        it('Get page 1 with products that has daysOnShelf = 5 and sorted by "title ASC, createdAt DESC"', (done)->
            Fakeproduct.pagify('products',
                findQuery:
                    daysOnShelf: 5
                sort: ["company ASC", "createdAt DESC"]
            ).then((obj)->
                expect(obj).to.have.all.keys('products', 'meta')

                # Check products
                assert.lengthOf obj.products, 2
                assert.equal obj.products[0].title, 'pagify-branded 2'
                assert.equal obj.products[1].title, 'pagify-branded 1'

                done()
            ).catch done
        )


