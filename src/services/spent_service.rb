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
    %w[spent_name spent_value total_spent total_amount].each do |method|
      send("load_#{method}")
    end
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
    @current_balance = gets.chomp.strip
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
    puts "| #{   spent_name_with_space     }| #{    spent_value_with_space     }| [x]      |"
  end

  def spent_value_with_space
    number_to_currency(@spent_value)
  end

  def number_to_currency(value)
    currency = "R$ #{(decimal(value).divmod 1).first},#{(decimal(value).divmod 1).last}"
    currency_with_space = currency
    (0..(33 - currency.length)).each { |_n| currency_with_space += ' ' }
    currency_with_space
  end

  def decimal(value)
    value.to_i / 100
  end

  def spent_name_with_space
    spent_with_space = @spent_name.capitalize
    (0..(31 - @spent_name.length)).each { |_n| spent_with_space += ' ' }
    spent_with_space
  end

  def raw_total
    puts '| Name                            | Price                             | Checked? |'
    puts '|:-------------------------------:|:---------------------------------:|:--------:|'
    puts "| Total Debits                    | #{     total_debits              }| [x]      |"
    puts "| Current Balance                 | #{     current_balance           }| [x]      |"
  end

  def total_debits
    number_to_currency(@total_spent.to_i + @spent_value.to_i)
  end

  def current_balance
    number_to_currency(@current_balance.to_i - @spent_value.to_i)
  end
end
