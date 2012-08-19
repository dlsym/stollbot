
#
# Stollbot
# 
# (c) 2012 Das Plutonium Imperium & @dlsym
# 

Twit = require 'twit'
StolliDB = require './stollidb'



# Say hi
console.log 'Welcome to Stollbot 0.5.15 (Flugscheibe)'

# Load quotes 
sdb = new StolliDB 'stolli.dat'

# Print test quote
console.log sdb.randomQuote()

console.log '-------------------------------------------------------'
console.log ''



twitter = new Twit
	consumer_key: ''
	consumer_secret: ''
	access_token: '',
	access_token_secret: ''


#
# User interactions
#
stream = twitter.stream 'user'
stream.on 'tweet', (tweet) =>
	replies = [ 'Ja. Heil.', 'Ja - heil.', 'Neger.', 'Muss man wissen.' ]
	r = Math.floor Math.random() * replies.length
	reply = replies[r]

	if tweet.in_reply_to_user_id? && tweet.user.screen_name != 'DrAxelStoll'
		twitter.post 'statuses/update'
			
			status: '@' + tweet.user.screen_name + ' ' + reply
			(err, result) ->
				if err?
					console.log '[-] Possible duplicate.'
				else
					console.log '[+] Rplto: @' + tweet.user.screen_name + ' ' + reply


#
# Helper functions
#
padstr = ->
	(Math.random().toString(36)).substr(0, Math.random()*10).replace /./g, ' '

interval = (ms, func) -> setInterval func, ms

#
# Post tweet (main stream)
#
post_tweet = (text) ->
	twitter.post 'statuses/update',
		status: quote,
		(err, result) ->
			console.log '[i] Tweet: ' + quote + padstr()
			if err?
				console.log '[-] Possible duplicate.'
	

interval 5500000, ->
	quote = sdb.randomQuote()
	post_tweet quote

interval 1562500, ->
	quote = sdb.randomQuote()
	post_tweet quote
