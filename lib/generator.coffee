Gen = require('rubber-stamp')


module.exports = (opts) ->
  {source, target} = opts

  gen = Gen.using(source, target, opts, "Generate a rubber-stamp generator")
    .mkdir()
    .mkdirs('lib', 'tests', 'files')
    .mkdirs('files/sources', 'files/targets')
    .mkdirs('files/sources/t1', 'files/targets/t1')
    .copy('index.js')
    .process('package.json')
    .copy('lib/generator.coffee')
    .copy('lib/get-inputs.coffee')
    .copy('files/sources/t1/placeholder.js')
    .copy('files/targets/t1/placeholder.js')
    .copy('tests/generator-test.coffee')

  -> gen.getRoot().apply()
