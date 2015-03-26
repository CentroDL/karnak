#**Karnak!**#
![Alt text](/public/img/karnak.jpg)


A Twitch.tv dashboard where you can view your subscribed streams all in one place like some cheesy super villain.

Check it out live on [Heroku](http://karnak.herokuapp.com/)

## The Approach

I started by hitting Twitch's base API to test it's viability. This is why the home page shows the top games off of Twitch since it was the easiest request to parse.  After some manual calls using the HTTParty gem, I was able to build out the '`/stream/twitch/:id`' route to present streams in a RESTful manner. `:id` is a symbol used for dynamic routing in Sinatra, it's a placeholder for stream names. If you know the channel name you can type it in place of `:id` and it'll embed the stream on it's own without you having to search a game first. The Hitbox API is admittedly not as nice as Twitch's, so I wrote a separate helper module to handle it's calls and formatting, and applied the same RESTful routing to build '`/stream/hitbox/:id`'. Keeping the helpers separate also allows us to individually deal with errors when one API goes down, as is the case when Twitch is running huge tournaments. 

## The Search Process

When you hit the `games/:game_name` route it parses the route name into a valid URL and then queries each API for matching games. Twitch by default matches partial requests, but in the HitboxHelper we use a regex match to pull out any matches. This is because Twitch allows for direct search results, but Hitbox will give you a collection of all streams regardless of the game you searched, so we have to add a line to filter out the game streams we want. In the end this allows you to search partial names and get the broadest range of results. 

Searching 'World of' can pull streams of 'World of Warcraft' & 'World of Tanks' together.

Searching 'Starcraft' can get you 'Starcraft: Brood War' & 'Starcraft II'

You can also search by Streamer/Channel name and get well targeted results. This benefits those trying to search tournament streams for the correct language, as larger events are sometimes simulcast for multiple audiences.