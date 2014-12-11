chai       = require 'chai'
{ expect } = chai
gen        = require '../lib/generator'
fs         = require 'fs'
path       = require 'path'
{ exists, mkdir, rm, contains } = require './verify-helpers'


describe 'generator =>', ->

  describe 'project generation =>', ->

    source = 'files/sources/s1'
    target = 'files/targets/t1'
    name   = 'new-project-test'

    createInputs = ->
      source      : source
      target      : target
      projectName : name

    beforeEach ->
      gen(createInputs())()

    it 'should create all dirs/ and files into the target dir/', ->
      exists(target, 'package.json')

    it 'should have interpolated the projectName into the package.json file', ->

      json = fs.readFileSync(path.resolve(target, 'package.json'), 'utf8')
      conf = JSON.parse(json)
      expect(conf.name).to.equal(name)
