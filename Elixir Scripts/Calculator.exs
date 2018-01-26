add = fn num1, num2 -> 
	num1 + num2
end

subtract = fn num1, num2 -> 
	num1 - num2
end

perform_calculation = fn num1, num2, func ->
	func.(num1, num2)
end

IO.inspect add.(1,2)

IO.inspect subtract.(2,4)

IO.inspect perform_calculation.(5, 5, add)
IO.inspect perform_calculation.(5, 5, subtract)
IO.inspect perform_calculation.(5, 5, fn a, b -> a * b end)

