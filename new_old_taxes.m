

monthlysalaries = [1629, 1756, 1947.50, 2103.50, 2243, 2347.50]; 
salaries = monthlysalaries*12; 
salarynames = {'pre-master''s I', 'pre-master''s II', 'post master''s', 'advanced', 'advnaced II', 'advanced III'}; 
S = length(salaries); 

standard_decuction_now = 4050; 
standard_decuction_future = 12200; 
personal_exemption_now = 6350; 
personal_exemption_future = 0; 

res.net_income.now = zeros(S, 1); 
res.net_income.future = zeros(S,1); 
res.tuition = 17331.50; 

nonres.net_income.now = zeros(S, 1); 
nonres.net_income.future = zeros(S,1); 
nonres.tuition = 32433.50; 

poverty = 12060; 
for s = 1:S
    
    % get amount of salary that is taxable 
    taxable_salary_now    = salaries(s) - standard_decuction_now - personal_exemption_now; 
    taxable_salary_future = salaries(s) - standard_decuction_future - personal_exemption_future; 
    
    if salaries(s) < 37951
        res.net_income.now(s)    = salaries(s) - taxable_salary_now*0.15;
        nonres.net_income.now(s) = salaries(s) - taxable_salary_now*0.15;
    end
    
    if salaries(s) + res.tuition < 38701
        fprintf('YES')
        res.net_income.future(s) = salaries(s) - (taxable_salary_future + res.tuition)*0.12; 
    elseif salaries(s) + res.tuition > 38701
        res.net_income.future(s) = salaries(s) - (taxable_salary_future  + res.tuition)*0.22; 
    end
    
    if salaries(s) + nonres.tuition < 38701
        fprintf('YES'); 
        nonres.net_income.future(s) = salaries(s) - (taxable_salary_future  + nonres.tuition)*0.12; 
    elseif salaries(s) + nonres.tuition > 38701
        nonres.net_income.future(s) = salaries(s) - (taxable_salary_future  + nonres.tuition)*0.22; 
    end
    
end

pct_salary_lost = round( (1 - res.net_income.future./res.net_income.now)*100); 
pct_salary_lost = arrayfun( @(x) [' (' num2str(x) '%)'], pct_salary_lost, 'UniformOutput', 0);


%% Plot 

h = figure(1); clf; 
h.Position = [360 151 720 547]; 
plot( res.net_income.now, 'bo', 'MarkerSize', 9, 'LineWidth', 1.5); hold on; 
plot( res.net_income.future, 'rx', 'MarkerSize', 9, 'LineWidth', 1.5); hold on; 
% plot( nonres.net_income.now, 'b--' ); hold on; 
% plot( nonres.net_income.future, 'ro' ); hold on; 
refline( 0, poverty); 

ylabel('Net Income ($)'); 
ytickformat('usd')

xlabel('Pay Step (% net income lost)'); 
labels = strcat( salarynames', pct_salary_lost); 
set(gca, 'XTick', 1:S); 
set(gca, 'XTickLabels', labels); 


legend('Location', 'best', {'Res Now', 'Res Tax Cut', 'Poverty Line'}); % , 'Non-Res Tax Cut'}); 

title( sprintf('Difference in Graduate Student Income\n Now and After Trump Tax Cut')); 

filenm = 'income_now_vs_tax_cut'; 
print(filenm, '-dpng'); 


