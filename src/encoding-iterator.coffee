# Copyright (c) 2015 Riceball LEE, MIT License
AbstractIterator      = require("abstract-iterator")
inherits              = require("abstract-object/lib/util/inherits")
isArray               = require("abstract-object/lib/util/isArray")
extend                = require("abstract-object/lib/util/_extend")


module.exports =  class EncodingIterator
  inherits EncodingIterator, AbstractIterator

  encodeOptions: (options)->
    keyEncoding = options.keyEncoding
    if keyEncoding
      options.lt = keyEncoding.encode(options.lt, options) if options.lt?
      options.lte = keyEncoding.encode(options.lte, options) if options.lte?
      options.gt = keyEncoding.encode(options.gt, options) if options.gt?
      options.gte = keyEncoding.encode(options.gte, options) if options.gte?
      if isArray options.range
        options.range = options.range.map (item)->
          keyEncoding.encode item, options
    options
  decodeResult: (result)->
    keyEncoding = @options.keyEncoding
    valueEncoding = @options.valueEncoding
    result[0] = keyEncoding.decode(result[0], @options) if result[0]? and keyEncoding
    result[1] = valueEncoding.decode(result[1], @options) if result[1]? and valueEncoding
    result

