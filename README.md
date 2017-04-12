# Noiseflag

## Overview

### Preview

[View the live project on Heroku](http://noiseflag.herokuapp.com/)

### Description

Noiseflag is an app for curating crowdsourced playlists around a geolocation. Users can plant flags at their current location or check in when nearby. Checked-in users can add tracks to the playlist and place votes. Without checking in, users may view the current playlist and in upcoming versions follow a link to a user's Spotify playlist.

## Technology

### Gems

rails  
pg  
dotenv-rails  
jbuilder  
geocoder
searchkick  
httparty  
will_paginate  
acts_as_votable  
carrierwave  
cloudinary   
devise  
omniauth-spotify  
bootstrap-sass  

### Installation

To run locally, clone the [repo](http://github.com/wilkdasilk/noiseflag) , bundle install, create the database, and start rails server. That's it! (note: current project lives at the styles branch, this will change shortly)

## Planning

[View the user stories](app/assets/images/user-stories.png)

[View the user wireframes](app/assets/images/Wireframes/)

[View the ERD](app/assets/images/ERD.png)

## Upcoming

Full support for login with Spotify, including pushing playlists and seeding from user recommendation data.

**Thanks for reading, now be noisy**
