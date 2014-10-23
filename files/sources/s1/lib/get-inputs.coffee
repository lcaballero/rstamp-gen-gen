qu        = require 'inquirer'
_         = require 'lodash'
path      = require 'path'
gen       = require './generator'
questions = require './questions'


module.exports = (rstampConf) ->
  qu.prompt(questions(rstampConf or {}), (answers) ->
    ins   = source : path.resolve(__dirname, "../files/sources/t1")
    opts  = _.defaults({}, ins, answers)

    gen(opts)()
  )