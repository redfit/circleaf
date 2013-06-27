jQuery ->
  unless $('.wmd-panel')[0]
    return

  converter = Markdown.getSanitizingConverter()
  Markdown.Extra.init(converter)
  editor = new Markdown.Editor(converter)
  editor.run()

  $('#wmd-input').auto_grow()
  $('.wmd-preview').on 'DOMSubtreeModified', (e) ->
    preview = $(@)
    attach_class = 'well'
    if $(@).text()
      preview.addClass(attach_class) unless preview.hasClass(attach_class)
    else
      preview.removeClass(attach_class) if preview.hasClass(attach_class)
