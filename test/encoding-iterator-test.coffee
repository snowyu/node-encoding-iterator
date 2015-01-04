chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
EncodingIterator= require '../src/encoding-iterator'
Errors          = require 'abstract-object/Error'
util            = require 'abstract-object/util'
inherits        = util.inherits
isFunction      = util.isFunction
setImmediate    = setImmediate || process.nextTick

chai.use(sinonChai)

describe "EncodingIterator", ->
  #before (done)->
  #after (done)->

  class FakeDB
    _mGetSync:->[["g0"],[0],["g1"],[1]]
    _mGet:(keys, options, callback)->
      if isFunction options
        callback = options
        options = {}
      callback(null, [["g0"],[0],["g1"],[1]]) if isFunction callback
  class FakeCodec
    encode:sinon.spy (v)->[v]
    decode:sinon.spy (v)->v[0]
  class FakeIterator
    inherits FakeIterator, EncodingIterator
    constructor: -> super
    @i: 0
    _nextSync: ->[["key"+FakeIterator.i], [FakeIterator.i++]]
  db = new FakeDB()
  codec = new FakeCodec()

  describe "encodeOptions", ->
    it "should encoding options", ->
      options = {keyEncoding: codec, valueEncoding: codec, lt:'abc'}
      it = new FakeIterator(db, options)
      codec.encode.should.have.been.calledWith('abc')
      codec.encode.should.have.returned(['abc'])
      it.options.lt.should.be.deep.equal ['abc']
  describe "next", ->
    it "should decode async next result correct", (done)->
      options = {keyEncoding: codec, valueEncoding: codec, lt:'abc'}
      it = new FakeIterator(db, options)
      codec.encode.should.have.been.calledWith('abc')
      codec.encode.should.have.returned(['abc'])
      it.options.lt.should.be.deep.equal ['abc']
      it.next (err, key, value)->
        should.not.exist err
        key.should.be.equal 'key0'
        value.should.be.equal 0
        done()
    it "should decode sync next result correct", ->
      options = {keyEncoding: codec, valueEncoding: codec, lt:'abc'}
      it = new FakeIterator(db, options)
      codec.encode.should.have.been.calledWith('abc')
      codec.encode.should.have.returned(['abc'])
      it.options.lt.should.be.deep.equal ['abc']
      result = it.nextSync()
      result.should.be.deep.equal {key:'key1', value:1}
    it "should decode async next range keys result correct", (done)->
      options = {keyEncoding: codec, valueEncoding: codec, range:['abc', 123]}
      it = new FakeIterator(db, options)
      codec.encode.should.have.been.calledWith('abc')
      codec.encode.should.have.returned(['abc'])
      it.options.range.should.be.deep.equal [['abc'], [123]]
      it.next (err, key, value)->
        should.not.exist err
        key.should.be.equal 'g0'
        value.should.be.equal 0
        done()
    it "should decode sync next result correct", ->
      options = {keyEncoding: codec, valueEncoding: codec, range:['abc']}
      it = new FakeIterator(db, options)
      codec.encode.should.have.been.calledWith('abc')
      codec.encode.should.have.returned(['abc'])
      result = it.nextSync()
      result.should.be.deep.equal {key:'g0', value:0}

