module Markdownable
  extend ActiveSupport::Concern

  module ClassMethods
    def markdownable(*fields)
      fields.each do |field|
        define_method "#{field}_markdown" do
          renderer = HtmlWithCodeRay.new(
            filter_html: true,
            prettify: true,
          )
          markdown = Redcarpet::Markdown.new(
            renderer,
            fenced_code_blocks: true, 
            autolink: true,
            tables: true,
          )
          text = self.send(field)
          markdown.render(text) unless text.nil?
        end
      end
    end
  end
end
