Gen   = require 'rubber-stamp'
fs    = require 'fs'
path  = require 'path'
_     = require 'lodash'


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

      # sources/s1
      .copy('files/sources/s1/package.json')

      # targets/t1
      .copy('files/targets/t1/.gitignore')

      # tests/
      .copy('tests/generator-test.coffee')
      .copy('tests/verify-helpers.coffee')
      .copy('tests/globals.coffee')
      .run(
        commands :
          if isTesting then []
          else [
            name: 'npm'
            args: [ 'install', 'coffee-script', 'lodash', 'nject', 'moment', 'rubber-stamp', 'async', 'inquirer', 'cli-color', '--save' ]
          ,
            name: 'npm'
            args: [ 'install', 'mocha', 'chai', 'sinon', 'sinon-chai', '--save-dev' ]
          ,
            name: 'git'
            args: [ 'init' ]
          ,
            name: 'chmod',
            args: [ '+x', opts.entryPoint ]
          ,
            name: 'npm'
            args: [ 'test' ]
          ]
      )
    )

  ->
    gen.apply()
