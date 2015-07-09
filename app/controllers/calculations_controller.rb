class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @text_array = @text.split
    @word_array = @text_array.find_all{|a| a == @special_word}

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = (@text.gsub(' ','')).length

    @word_count =  @text_array.count

    @occurrences = @word_array.count

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @effective = @apr/100/12
    @periods = @years*12

    @monthly_payment = @principal * ( @effective / (1 - (1 + @effective)**-@periods))

  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    @median = (
        if @count.to_i.odd?
            @sorted_numbers.at(@count.to_i/2 + 1)
        else
            (@sorted_numbers.at(@count/2)+@sorted_numbers.at(@count/2+1))/2
        end)

    @sum = sum_array(Array.new(@sorted_numbers))

    @mean = @sum/@count

    @variance = square_array(Array.new(@sorted_numbers), @mean)/@count

    @standard_deviation = Math.sqrt(@variance)

    @mode = "Replace this string with your answer."
  end


  def sum_array number_array
    if number_array.count == 0
        return 0
    else
        number_array.pop + sum_array(number_array)
    end
  end

  def square_array(number_array, array_mean)
    if number_array.count == 0
        return 0
    else
        return (number_array.pop - array_mean)**2 + square_array(number_array, array_mean)
    end
  end




end
