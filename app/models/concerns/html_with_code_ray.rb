class HtmlWithCodeRay < Redcarpet::Render::HTML
  def block_code(code, lang)
    begin
      CodeRay.scan(code, lang).div
    rescue
      lang = nil
      retry
    end
  end
end
