class Integer
  def !()
    if self > 0
      return (self - 1).! * self
    else
      return 1
    end
  end
end

if __FILE__ == $0
  ARGV.each do |s|
    i = s.to_i
    if i >= 0 && i <= 100
      puts "#{i}! = #{i.!}"
    else
      warn "#{i} is under 0 or over 100."
    end
  end
end
