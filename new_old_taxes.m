

monthlysalaries = [1629, 1756, 1947.50, 2103.50, 2243, 2347.50]; 
salaries = monthlysalaries*12; 
salarynames = {'pre-master''s I', 'pre-master''s II', 'post master''s', 'advanced', 'advnaced II', 'advanced III'}; 
S = length(salaries); 

res.net_income.now = zeros(S, 1); 
res.net_income.future = zeros(S,1); 
res.tuition = 17331.50; 

nonres.net_income.now = zeros(S, 1); 
nonres.net_income.future = zeros(S,1); 
nonres.tuition = 32433.50; 

poverty = 12060; 
for s = 1:S
    
    if salaries(s) < 37951
        res.net_income.now(s) = salaries(s) - salaries(s)*0.15;
        nonres.net_income.now(s) = salaries(s) - salaries(s)*0.15;
    end
    
    if salaries(s) + res.tuition < 38701
        fprintf('YES')
        res.net_income.future(s) = salaries(s) - (salaries(s) + res.tuition)*0.12; 
    elseif salaries(s) + res.tuition > 38701
        res.net_income.future(s) = salaries(s) - (salaries(s) + res.tuition)*0.22; 
    end
    
    if salaries(s) + nonres.tuition < 38701
        fprintf('YES'); 
        nonres.net_income.future(s) = salaries(s) - (salaries(s) + nonres.tuition)*0.12; 
    elseif salaries(s) + nonres.tuition > 38701
        nonres.net_income.future(s) = salaries(s) - (salaries(s) + nonres.tuition)*0.22; 
    end
    
end

%% Plot 

figure(1); clf; 
plot( res.net_income.now, 'bo' ); hold on; 
plot( res.net_income.future, 'rx'); hold on; 
% plot( nonres.net_income.now, 'b--' ); hold on; 
% plot( nonres.net_income.future, 'ro' ); hold on; 

refline( 0, poverty); 

ylabel('Net Income ($)'); 
xlabel('Pay Step'); 

set(gca, 'XTick', 1:S); 
set(gca, 'XTickLabels', salarynames); 

% legend('Location', 'best', {'Res/Non-Res Now', 'Res Tax Cut', 'Non-Res Tax Cut', 'Poverty Line'}); % , 'Non-Res Tax Cut'}); 
legend('Location', 'best', {'Res Now', 'Res Tax Cut', 'Poverty Line'}); % , 'Non-Res Tax Cut'}); 

filenm = 'income_now_and_with_tax_cut'; 
print(filenm, '-dpng'); 


