Gen   = require 'rubber-stamp'
fs    = require 'fs'
path  = require 'path'


module.exports = (opts, isTesting) ->
  { source, target } = opts

  inputsPackage = (inputs) ->
    name        : inputs.name
    version     : inputs.version
    description : inputs.description
    author      : inputs.author
    main        : inputs.entryPoint
    keywords    : do ->
      keywords = _.compact((inputs.keywords or "").split(" "))
      if keywords.length > 0
        keywords
      else
        []
    license     : inputs.license or "Eclipse Public License (EPL)"
    repository  : inputs.repo
    scripts     :
      test: inputs.testCommand or ""

  createPackage = (g) ->
    model       = g.getModel()
    packageJson = inputsPackage(model)
    json        = JSON.stringify(packageJson, null, '  ')
    fs.writeFileSync(g.to('package.json'), json, 'utf8')


  gen = Gen.using(source, target, opts, "Generate a rubber-stamp generator")
    .mkdir()
    .add((g) ->
      createPackage(g)

      g.mkdirs(
        'lib'
        'tests'
        'files'
        'files/sources'
        'files/targets'
        'files/sources/s1')

      # /
      .copy('index.js')
      .copy('license')
      .copy('.gitignore')

      # lib/
      .copy('lib/generator.coffee')
      .copy('lib/get-inputs.coffee')
      .copy('lib/questions.coffee')

      # targets/t1
      .copy('files/targets/t1/.gitignore')

      # tests/
      .copy('tests/generator-test.coffee')
      .copy('tests/verify-helpers.coffee')
      .copy('tests/globals.coffee')
    )

  ->
    gen.apply()
