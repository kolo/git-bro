helpers do
  def partial(template, options = {})
    haml template, options.merge!(:layout => false)
  end
end
