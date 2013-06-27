# ishikitakai.com

## Setup for development

rename Guardfile.example to Guardfile

```
$ cp Guardfile.example Guardfile
```

## External API Credential

```
cp config/application.yml.example config/application.yml
```

Fill in api credential

## Start foreman

```
$ foreman start -f Procfile.development
```

## heroku

```
heroku addons:add pusher:sandbox
heroku addons:add mandrill:starter
```
