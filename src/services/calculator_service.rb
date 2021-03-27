class CalculatorService
  def initialize
    @result = 0
    @math_expression = ''
    @continue = true
  end

  def execute
    while @continue
      load_expression
      calc
      check_continue
    end
  end

  private

  def load_expression
    puts
    puts 'Type your expression:'
    @math_expression = gets.chomp.strip
  end

  def calc
    @math_expression.split(/[()]/).reverse.each do |expression|
      @result += expression.to_i
    end
    puts @result
    puts
  end

  def check_continue
    puts 'continue? (y/n)'
    @continue = gets.chomp.strip.upcase == 'Y'
    puts
  end
end
