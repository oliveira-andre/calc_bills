# frozen_string_literal: true

require 'bigdecimal'

class SpentService
  def initialize
    @spent_value = 0
    @spent_name = 0
    @total_spent = 0
    @total_amount = 0
    @column_space = 35
  end

  def execute
    puts
    load_values
    raw_result
    puts
  end

  private

  def load_values
    load_spent_name
    load_spent_value
    load_total_spent
    load_total_amount
  end

  def load_spent_name
    puts 'What do you spent: '
    @spent_name = gets.chomp.strip
  end

  def load_spent_value
    puts 'How much you spent (no points, no commas, ex: 1300 == 13.00): '
    @spent_value = gets.chomp.strip
  end

  def load_total_spent
    puts 'How much is your current total spent (no points, no commas, ex: 1300 == 13.00): '
    @total_spent = gets.chomp.strip
  end

  def load_total_amount
    puts 'How much is your total amount (no points, no commas, ex: 1300 == 13.00): '
    @total_amount = gets.chomp.strip
  end

  def raw_result
    puts
    raw_spent
    puts
    raw_total
  end

  def raw_spent
    puts '| Name                            | Price                             | Checked? |'
    puts '|:-------------------------------:|:---------------------------------:|:--------:|'
    puts "|#{    spent_name_with_space     }|#{      spent_value_with_space    }| [x]      |"
  end

  def spent_decimal
    @spent_value.to_i / 100
  end

  def spent_value_with_space
    spent_value = "R$ #{(spent_decimal.divmod 1).first},#{(spent_decimal.divmod 1).last}"
    spent_with_space = spent_value
    (0..(34 - spent_value.length)).each { |_n| spent_with_space += ' ' }
    spent_with_space
  end

  def spent_name_with_space
    spent_with_space = @spent_name.capitalize
    (0..(32 - @spent_name.length)).each { |_n| spent_with_space += ' ' }
    spent_with_space
  end

  def raw_total; end
end
