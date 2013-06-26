jQuery ->
  unless $('.wmd-panel')[0]
    return

  converter = Markdown.getSanitizingConverter()
  editor = new Markdown.Editor(converter)
  editor.run()
