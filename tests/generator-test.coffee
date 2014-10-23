gen        = require '../lib/generator'
fs         = require 'fs'
path       = require 'path'
_          = require 'lodash'
{ exists, mkdir, rm, contains } = require './verify-helpers'



describe 'generator =>', ->

  describe 'project generation =>', ->

    source      = 'files/sources/s1'
    target      = 'files/targets/t1'

    projectName = 'new-project-test'
    version     = '2010.1.1'
    author      = 'Bruce Wayne'
    entryPoint  = 'main.js'
    keywords    = 'words that are key'
    license     = 'MIT'
    repository  = 'github'
    scripts     =
      test: 'testing command'

    createInputs = ->
      source          : source
      target          : target
      projectName     : projectName
      name            : projectName
      version         : version
      author          : author
      entryPoint      : entryPoint
      keywords        : keywords
      repo            : repository
      license         : license
      testCommand     : scripts.test

    opts = createInputs()

    beforeEach (done) ->
      mkdir 'files/targets', 't1', done

    beforeEach ->
      gen(opts)()

    afterEach (done) ->
#      rm 'files/targets', 't1', done
      done()

    it 'check setup', ->
      expect(opts).to.exist

    it 'should create all dirs/ and files into the target dir/', ->

      exists(target
        'lib'
        'tests'
        'files'
        'files/sources'
        'files/sources/s1'
        'files/targets/t1/.gitignore'
        'lib/generator.coffee'
        'lib/get-inputs.coffee'
        'lib/questions.coffee'
        'tests/generator-test.coffee'
        'tests/verify-helpers.coffee'
        'tests/globals.coffee'
        'index.js'
        'license'
        '.gitignore'
      )

    for a,b of _.omit(opts, 'keywords', 'source', 'target')
      ((k,v) ->
        it "should have interpolated the #{k} into the package.json file", ->
          contains(target, 'package.json', v))(a,b)


    for w in _.compact((opts.keywords or "").split(" "))
      ((word) ->
        it "should have interpolated the #{word} into the package.json file", ->
          contains(target, 'package.json', "\"#{word}\""))(w)



