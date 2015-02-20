# Adjective Backend API 

> **Note**: This is not a complete product until release 1.0.0 at the earliest. I am still in the drafting phases of work, and will update it as regularly as humanly possible. For now, I have simple models for objects set up and ready for customization. 

### Purpose of this Project

Adjective is a game engine started by myself to help alleviate some of the monotony you have to deal with when making an RPG from scratch. Much of the system makes it simple for anyone, even relative beginners, to get a simple game going as quickly as possible. Instead of focusing on graphics and more 'showy' aspects of game development, this package is intended to be used to set up your backend API and/or server. 

It is written in mostly Javascript and Ruby. I am currently using Sinatra as opposed to Rails, since I don't think making an API requires all of the utility that Rails provides for creating apps. 

I use ActiveRecord with Postgresql. It keeps things simple, yet I have the power to create relationships on a whim. 
The main merit of this API is the simple fact that I have provided a ton of templated and readily-generatable databse content. You just have to run a few commands and you have API to serve games with up and running. 

### Quickstart

1.  `bundle install` Installs the gems needed. 
2.  `be shotgun` Starts the server.
3.  `be thin start` Starts a thin server. Requires restart when you make changes, but loads a LOT faster than Shotgun. 

#Create premade models and migrations with rake tasks:

```
be rake generate:construct 
#Create a Development Suite with preset models, migrations, and ready-to-go tables. 

be rake generate:character 
#Create a character model and migration file with specifications for an in-game character. 

be rake generate:user 
#Create a user model and migration with BCrypt already integrated in to it. 

be rake generate:enemy 
#Create a generic enemy model and migration; very similar to the character model.

be rake generate:location 
#Create a specialized model and migration used for standard cardinal directions (and/or simple x/y) coordinates.


```

### Contributing

Let me know if you'd like to make a contribution to Adjective. I am open to any design or techincal suggestions. 

Be explicit in your pull request if so. Thanks!
