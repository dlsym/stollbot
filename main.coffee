
#
# Stollbot
# 
# (c) 2012 Das Plutonium Imperium & @dlsym
# 

Twit      = require 'twit'
StolliDB  = require './stollidb'
Stollator = require './stollator'

fs = require 'fs'




# Say hi
console.log 'Welcome to Stollbot 0.5.15 (Flugscheibe)'

# Load quotes 
sdb       = new StolliDB 'stolli.dat'
stollator = new Stollator 'phrases.dat' 

# Print test quote
console.log sdb.randomQuote()

console.log '-------------------------------------------------------'
console.log ''



twitter = new Twit
	consumer_key: ''
	consumer_secret: ''
	access_token: '',
	access_token_secret: ''


log = fs.createWriteStream 'stollog.log'
	flags: 'a'


#
# User interactions
#
stream = twitter.stream 'user'
stream.on 'tweet', (tweet) =>
	###
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
	log.write "-----------------------------------------------\n"
	log.write JSON.stringify(tweet)
	log.write "\n"
	console.log '[i] Added tweet to log...'
	###
	
	


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
		status: text + padstr(),
		(err, result) ->
			console.log '[i] Tweet: ' + text
			if err?
				console.log '[-] Possible duplicate.'
	

interval 4600000, ->
	quote = sdb.randomQuote()
	post_tweet quote

interval 3700000, ->
	quote = sdb.randomQuote()
	post_tweet quote

interval 1700000, ->
	console.log "[i] Creating Stolliquote!"
	quote = sollator.make_quote()
	post_tweet quote


quote = stollator.make_quote()
post_tweet quote


