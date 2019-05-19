---
published: true
layout: project
title: Corkboard
"short-title": Corkboard
project-url: https://corkboard-demo.herokuapp.com
source-url: https://github.com/kmrn/corkboard/
date: "2019-05-19"
categories: projects
image: /images/corkboard.png
---

Corkboard is a social bulletin board thing I created in a couple hours in order to teach myself how to use Meteor's MVC structure and React. It also uses MongoDB and ES6. It features frontend stuff, backend stuff, real time DOM manipulation, server side data stuff, and other stuff like that.

## The Views

![the app](/images/corkboard.png)

The UI is pretty straightforward. You can press the "Post Something" button to post something onto the public bulletin board that everyone else can see posted in real time. People can also see how long ago each note was posted which is also updated for them in real time. Each little note card also has a small heart that you can click in order to show your appreciation of that note. The number next to the heart is also updated in real time so that everyone knows how loved a note is.

The CSS for this project is mostly custom but also uses [Skeleton](http://getskeleton.com) and Normalize (kind of like a lot of the things I make). I've written about Skeleton before and but it's an incredibly simple responsive CSS boilerplate. I find libraries like Bootstrap or Foundation are way too bloated and full of unnecessary features for fast and small projects like this and end up being total overkill.


## Technologies
What's actually important here is what's under the hood. This is meant to be a small demo using some pretty popular technologies that I taught myself how to use over the weekend in order to stay on trend. I knew I wanted to make some sort of full stack NodeJS app in order to show my understanding of MVC structures and such (I can't just post stuff I write at work on [my GitHub](https://github.com/kmrn) unforunately).

The app itself is using a NodeJS framework called [Meteor](https://www.meteor.com). I just started using it about a day before writing this and I gotta say I really like it. MongoDB is pretty interesting and neat to work with and Meteor's approach to Model-View-Controller setups makes creating a full stack web app pretty enjoyable. This Meteor app and corresponding Mongo Database is currently being hosted on a free Heroku dyno.

Meteor gives you the option to forgo it's built in templating system, Blaze, in favor of Angular or React. I immediately wanted to use React for this because it's something I hadn't used yet and really felt like it was something I needed to learn. All of corkboard's templating and real time DOM manipulations are done using React. My friends told me React can get a little weird and I was a little skeptical of JSX at first but after working on this portfolio piece it really grew on me.


Scroll back up to the top of this article for the two buttons that can take you to the project and its GitHub repository.
