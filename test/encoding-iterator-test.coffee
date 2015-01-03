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
      _mGetSync:->[]
      _mGet:(keys, options, callback)->
        if isFunction options
          callback = options
          options = {}
        callback(null, []) if isFunction callback
