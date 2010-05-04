class Time
  def relative_to(time)
    diff = time - self

    return "#{diff.to_i} seconds ago" if diff < 60
    return "#{(diff/60).to_i} minutes ago" if diff < 3600
    return "#{(diff/3600).to_i} hours ago" if diff < 86400
    return "#{(diff/86400).to_i} days ago" if diff < 604800

    self.strftime("%B %d, %Y")
  end
end

class String
  def shortify(len = 40)
    if self.length > len
      return self[0..len-1] + "..."
    end

    self
  end
end
