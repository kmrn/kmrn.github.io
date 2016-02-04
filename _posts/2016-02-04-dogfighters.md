---
published: true
layout: project
title: Dogfighters
"short-title": Dogfighters
date: 2016-02-04
categories: projects
image: /images/dogfighters_thumb.png
---

<div class="portfolio-links">
    <a href="http://kamranpayne.com/dogfighters" class="button button-primary">Go to this Project</a>
    <a href="https://github.com/ron953/dogfighters/" class="button">View Source</a>
</div>

This past weekend I tried to make something different. I think it went alright. I wanted to get more into game development and make something really cool that I could potentially make into a bigger project further down the road. I thought some sort of multiplayer casual game would be cool so that's what I made.

###Technologies
For this project I used the popular web game engine [Phaser](http://phaser.io). For realtime online multiplayer I used [Firebase](http://firebase.com). It's a fairly simple demo that combines these two libraries in a pretty neat way. All the players use their unique login ID as a key to identify them in online play. A temporary one is generated for all players using Firebase's built in authentication. When people enter the game, they get logged in anonymously.

###Gameplay
There's not actually a lot in the way of gameplay at the moment and I'm not entirely sure if there will be. As of right now all that's being sent and received over Firebase is player locations, so you can move around and shoot but you can't actually interact with each other yet. I'm still debating on whether or not this is a project I'll carry to completion or if I should work on something different.


You can go check out this demo at [kamranpayne.com/dogfighters](kamranpayne.com/dogfighters) and keep a look out for the next thing I make because hopefully it'll be an actual game that people can play.
