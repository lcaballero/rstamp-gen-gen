Gen = require('rubber-stamp')


module.exports = (opts) ->
  {source, target} = opts

  gen = Gen.using(source, target, opts, "Generate a rubber-stamp generator")
  .mkdir()
  .mkdirs('lib', 'tests', 'files')
  .mkdirs('files/sources', 'files/targets', 'files/sources/t1')
  .copy('index.js')
  .process('package.json')
  .copy('files/lib/generator.coffee')
  .copy('files/lib/get-inputs.coffee')
  .copy('files/sources/t1/placeholder.js')
  .copy('files/targets/t1/placeholder.js')

  -> gen.apply()