helpers do
  def partial(template, options = {})
    haml template, options.merge!(:layout => false)
  end

  def render_path(p, branch)
    path_parts = p.split('/')
    url_prefix = "/tree/#{branch}"

    repository_name = path_parts.delete_at(0)
    haml_tag :span do
      haml_tag :a, repository_name, {:href => url_prefix, :id => "repo-name"}
    end
    haml_tag :span, "/"

    unless path_parts.empty?
      url_prefix += '/'
      last_part = path_parts.delete_at(-1)

      path_parts.each do |i|
        url_prefix += "#{i}/"
        haml_tag :span do
          haml_tag :a, i, {:href => url_prefix}
        end
        haml_tag :span, "/"
      end

      haml_tag :span, last_part
    end
  end

  def highlight(code, lang, options = nil)
    options[:tag] = :div unless options[:tag]
    case options[:tag]
    when :div
      html = CodeRay.scan(code, lang).div(:css => :class, :line_numbers => options[:line_numbers])
    when :span
      html = CodeRay.scan(code, lang).span(:css => :class, :line_numbers => options[:line_numbers])
    end
  end
end
