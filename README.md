# Nosql Encoding Iterator.

[![Build Status](https://secure.travis-ci.org/snowyu/node-encoding-iterator.png?branch=master)](http://travis-ci.org/snowyu/node-encoding-iterator)

[![NPM](https://nodei.co/npm/encoding-iterator.png?stars&downloads&downloadRank)](https://nodei.co/npm/encoding-iterator/)

Add the encoding ability to the [abstract-iterator](https://github.com/snowyu/abstract-iterator).

# Usage

## Add the Encoding ability to a nosql database

Just see the [nosql-encoding](https://github.com/snowyu/node-nosql-encoding)


```js
var addEncodingFeatureTo = require("nosql-encoding")
var LevelDB  = addEncodingFeatureTo(require("leveldown-sync"))

var db = LevelDB('location')
db.open({keyEncoding: 'text', valueEncoding: 'json'})

```

## Develop a nosql iterator with encoding ability

There is no need to force inherited from the Encoding class.

Please let the user decide whether to use the Encoding feature.

# Encoding Codec

See [buffer-codec](https://github.com/snowyu/buffer-codec).


