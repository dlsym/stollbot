

fs = require 'fs'

# 
# Stollator - Autogenerate Axel Stoll quote
#
# (c) 2012 Das Plutonium Imperium & @dlsym 
#
class Stollator

	constructor: (@dbfile) ->
	    # load stollij
		console.log "[i] Loading #{@dbfile}"
		quotes = fs.readFileSync(@dbfile).toString().split '\n'

		current_section = null

		for quote in quotes
			# skip empty lines
			if quote == ""
				continue

			# is section?
			match = quote.match /\[(.*)\]/
			if match
				section = match[1]
				if section != current_section
					current_section = section
					continue

			# add quote to section
			if @[current_section] not instanceof Array
				@[current_section] = []

			@[current_section].push quote

	#
	# Create quote
	#
	make_quote: ->
		idea = @ideas[ Math.floor(Math.random()*@ideas.length) ]
		
		affirm_prop   = Math.floor( Math.random()*10 )
		appendix_prop = Math.floor( Math.random()*10 )
		
		if affirm_prop > 5
			idea += ' ' + @affirmation[ Math.floor(Math.random()*@affirmation.length ) ]
			
		if appendix_prop > 3
			idea += ' ' + @appendix[ Math.floor(Math.random()*@appendix.length ) ]

		# return fresh quote
		idea



module.exports = Stollator



