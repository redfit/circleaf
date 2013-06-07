jQuery ->
  unless $('body').hasClass('posts')
    return

  group_id = $('body').attr('data-group-id')
  post = new Post(group_id)
  window.App.post = post

class Post
  group_id: null
  channel: null
  constructor: (group_id) ->
    @group_id = group_id
    @init()

  init: ->
    Pusher.channel_auth_endpoint = '/pusher/authentication'
    if rack_env isnt 'production'
      Pusher.log = (message) -> console.log(message)
    @dom()
    @subscribe()
    @listen()

  dom: ->
    $('textarea').focus()
    $('textarea').keydown (event) ->
      event.stopPropagation()
      if event.keyCode == 13
        return if event.shiftKey
        $(@).parent().submit()

    $('form#new_post').submit (event) ->
      $('.progress').show()

    $('ul.posts a').on 'click', (event) ->
      event.preventDefault()
      url = $(@).attr('href')
      window.open url

  subscribe: ->
    @channel = pusher.subscribe("presence-group_posts_#{@group_id}")

  listen: ->
    @channel.bind 'post', (data) =>
      @fetch(data.id)
      return
    
    @channel.bind 'pusher:subscription_succeeded', (members) =>
      members.each (member) =>
        @add_member(member)
      return

    @channel.bind 'pusher:subscription_error', (data) ->
      return
      
    @channel.bind 'pusher:member_added', (data) =>
      @add_member(data)
      return
    
    @channel.bind 'pusher:member_removed', (data) ->
      $('ul.member').find('[data-class="chat_user"][data-id="' + data.id.toString() + '"]').closest('li').remove()
      return

  fetch: (id) ->
    $.ajax(
      url: '/posts/' + id,
      success: (data) ->
        $('ul.posts').append("<li class='media'>#{data}</li>")
        $('.progress').hide()
        return
    )
    return true

  add_member: (member) ->
    $('ul.member').find('[data-class="chat_user"][data-id="' + member.id.toString() + '"]').closest('li').remove()
    $('ul.member').append(
      '<li><img src="' + member.info.image + '" width="25" height="25" class="face" data-class="chat_user" data-id="' + member.id.toString() + '"></li>')
