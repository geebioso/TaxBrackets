function [total_taxes]  = compute_tax_owed(salary0, lower, upper, rate, owed, deduct, pep, pexemp)

% take a deduction if salary is below PEP threshold 
salary = salary0; 
if salary < pep
    salary = salary - deduct; 
end

% take personal examption 
salary = salary - pexemp; 

% if the deduction plus exemption are greater than or equal taxes owed, set salary
% to 0 and set bracket to lowest 
if salary <= 0
   salary = 0; 
   bracket = lower < salary; 
   bracket(1) = 1; 
else
   % find the tax bracket 
    lower_ii = lower < salary; 
    upper_ii = upper >= salary; 
    bracket = and(lower_ii, upper_ii);  
end

% calculate tax from previous brackets 
% rate in bracket times upper limit of those brackets 
prev_bracket_taxes = owed(bracket); 

% calculate tax from current bracket
% rate in bracket times how much we exceed our bracket minimum by
salary_in_bracket = salary - lower(bracket); 
in_bracket_taxes =  salary_in_bracket*rate(bracket);

total_taxes = prev_bracket_taxes + in_bracket_taxes; 

end