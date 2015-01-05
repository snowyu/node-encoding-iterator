# Copyright (c) 2015 Riceball LEE, MIT License
util                  = require("abstract-object/lib/util")
AbstractIterator      = require("abstract-iterator")
inherits              = util.inherits
isArray               = util.isArray


module.exports =  class EncodingIterator
  inherits EncodingIterator, AbstractIterator

  encodeOptions: (options)->
    keyEncoding = options.keyEncoding
    if keyEncoding
      options.lt = keyEncoding.encode(options.lt) if options.lt?
      options.lte = keyEncoding.encode(options.lte) if options.lte?
      options.gt = keyEncoding.encode(options.gt) if options.gt?
      options.gte = keyEncoding.encode(options.gte) if options.gte?
      options.range = options.range.map keyEncoding.encode.bind(keyEncoding) if isArray options.range
    options
  decodeResult: (result)->
    keyEncoding = @options.keyEncoding
    valueEncoding = @options.valueEncoding
    result[0] = keyEncoding.decode(result[0]) if result[0]? and keyEncoding
    result[1] = valueEncoding.decode(result[1]) if result[1]? and valueEncoding
    result

