# frozen_string_literal: true

require 'byebug'

Dir['./src/services/*.rb'].sort.each { |file| require file }

class CalcBills
  def initialize
    @still_running = true
    @option = nil
  end

  def execute
    show_and_choose_option while @still_running
  end

  private

  def show_and_choose_option
    show_options
    choose_option
  end

  def show_options
    puts '1 - Calculate some spent'
    puts '2 - Calculator'
    puts '0 - exit'
    puts
  end

  def choose_option
    puts 'Choose your option: '
    @option = gets.chomp.strip

    case @option.to_i
    when 1
      SpentService.new.execute
    when 2
      CalculatorService.new.execute
    when 0
      @still_running = false
    else
      puts 'Please select a valid option!'
    end
  end
end

CalcBills.new.execute
