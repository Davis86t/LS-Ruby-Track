def prompt(message)
  Kernel.puts("=> #{message}")
end

prompt("-----------------------------------")
prompt("Welcome to the Mortgage Calculator!")
prompt("-----------------------------------")

loop do # main loop
  loan_amount = ''
  loop do
    prompt("Please enter the loan amount:")
    loan_amount = Kernel.gets().chomp()

    if loan_amount.empty?() || loan_amount.to_f() < 0
      prompt("Hmm... that doesn't look like a valid number")
    else
      break
    end
  end

  apr = ''
  loop do
    prompt("Enter the Annual Percentage Rate (APR):")
    prompt("(Example: 5 for 5% or 2.5 for 2.5%)")
    apr = Kernel.gets().chomp()

    if apr.empty?() || apr.to_f() < 0
      prompt("Hmm... that doesn't look like a valid number")
    else
      break
    end
  end

  duration_years = ''
  loop do
    prompt("Enter the length of the loan, in years:")
    duration_years = Kernel.gets().chomp()

    if duration_years.empty?() || duration_years.to_i() < 0
      prompt("Hmm... that doesn't look like a valid number")
    else
      break
    end
  end

  annual_interest_rate = apr.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  duration_months = duration_years.to_i() * 12

  monthly_payment = loan_amount.to_f() *
                    (monthly_interest_rate / 
                    (1 - (1 + monthly_interest_rate)**(-duration_months)))

  prompt("---------------------------------------")
  prompt("The monthly payment amount is: $#{format('%.2f', monthly_payment)}")
  prompt("---------------------------------------")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the calculator. Good bye!")
