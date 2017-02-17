class Test

  def initialize num
    @num = num
    @str = "string"
  end

  def num
    @num
  end

  def str
    @str
  end


end

class ChildTest < Test

  def initialize
    super(4)
    @num = 9
    @string = "sdasd"
    @num2 =-9
  end

end

arr = [ChildTest.new]
puts arr.select { |i|
  #i => "3" is i.class = Test ITS NOT its a String
  #etc...
  #i => Test.new is i a Test YES ok, then we need to see if i's variable num is == 4
  i.class==Test && i.num > 2

}

arr.each {|i|
  puts "I's @num is #{i.num}"
}
