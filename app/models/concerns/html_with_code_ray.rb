class HtmlWithCodeRay < Redcarpet::Render::HTML
  def block_code(code, lang)
    CodeRay.scan(code, lang).div
  end
end
