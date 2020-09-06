# ShortenUrl App

## SETUP

Some basic Git commands are:
```
git clone git@github.com:vijayshankar037/url_shortener.git
cd url_shortener
bundle install
rake db:create db:migrate db:seed
```

## HEROKU URL
 Following URL short the url
  https://murmuring-inlet-01393.herokuapp.com/

  ![UrlShortener](https://user-images.githubusercontent.com/6635787/92331208-a279bc80-f092-11ea-9a05-1b8e5195c40f.png)

Following URL list the stats for each link
  https://murmuring-inlet-01393.herokuapp.com/stats
  ![stats](https://user-images.githubusercontent.com/6635787/92331210-a73e7080-f092-11ea-89f5-3b47654f4114.png)

## Expiration
 When user create a shorter URI we set the `expiration` of `30 days` if that time expires user will get the 404 message. 
