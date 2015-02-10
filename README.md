# Adjective 

> **Note**: This is not a complete product until release 1.0.0 at the earliest. I am still in the drafting phases of work, and will update it as regularly as humanly possible. For now, I have simple models for objects set up and ready for customization. 

### Purpose of this Project

Adjective is a game engine started by myself to help alleviate some of the monotony you have to deal with when making an RPG from scratch. Much of the system makes it simple for anyone, even relative beginners, to get a simple game going as quickly as possible. Instead of focusing on graphics and more 'showy' aspects of game development, this package is intended to be used to set up your backend API and/or server. 

It is written in mostly Javascript and Ruby. I am still deciding on what libraries I am going to use for the UI elements, but I think that Famo.us has an awesome system set up. 

### Quickstart

1.  `bundle install`
2.  `be shotgun`

As needed, create models & migrations with the `rake` tasks:

```
rake generate:migration  # Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks
rake generate:model      # Create an empty model in app/models, e.g., rake generate:model NAME=User
```

### Contributing

Let me know if you'd like to make a contribution to Adjective. I am open to any design or techincal suggestions. 

Be explicit in your pull request if so. Thanks!
