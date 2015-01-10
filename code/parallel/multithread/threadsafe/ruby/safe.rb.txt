ths = []
a = 0
b = 0
m = Mutex.new
100.times do
  ths << Thread.new do
    Thread.pass
    1000.times do
      m.synchronize do
        b = a
        print b.to_s + "\r"
        $stdout.flush
        a = b + 1
      end
    end
  end
end
ths.each do |th|
  th.join
end
puts a
