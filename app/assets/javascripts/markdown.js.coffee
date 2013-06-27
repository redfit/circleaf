jQuery ->
  unless $('.wmd-panel')[0]
    return

  converter = Markdown.getSanitizingConverter()
  Markdown.Extra.init(converter)
  editor = new Markdown.Editor(converter)
  editor.run()
