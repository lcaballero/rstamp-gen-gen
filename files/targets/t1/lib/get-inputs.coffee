qu    = require 'inquirer'
_     = require 'lodash'
path  = require 'path'
gen   = require './generator'


questions = [
  {
    name    : "target"
    type    : "input"
    message : "Where would you like to write the project?"
    default : "."
  }
  {
    name    : "projectName"
    type    : "input"
    message : "What would you like to name the project?"
  }
]

qu.prompt(questions, (answer) ->
  answer.source = path.resolve(__dirname, "../files/sources/t1")
  gen(answer)()
)