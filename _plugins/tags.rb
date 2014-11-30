module Jekyll
	class RenderLine < Liquid::Tag

		def initialize(tag_name, filename, tokens)
			super
			@text = File.readlines("bio.txt").sample
		end

		def render(context)
			"#{@text}"
		end
	end
end

Liquid::Template.register_tag('random_line', Jekyll::RenderLine)