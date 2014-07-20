Gen = require('rubber-stamp')


module.exports = (opts) ->
  {source, target} = opts

  gen = Gen.using(source, target, opts, "Generate a rubber-stamp generator")
    .mkdir()
    .copy('placeholder.js')


  -> gen.apply()