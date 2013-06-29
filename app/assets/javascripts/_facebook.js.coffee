fb_root = null
fb_events_bound = false

$ ->
  if rack_env isnt 'test'
    loadFacebookSDK()
    bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/ja_JP/all.js#xfbml=1")

initializeFacebookSDK = ->
  FB.init
#    appId     : 'YOUR_APP_ID'
#    channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html'
    status    : true
    cookie    : true
    xfbml     : true
