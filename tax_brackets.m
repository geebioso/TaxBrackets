
% bracket tax rates 
rate = [.1, .15, .25, .28, .33, .35, .3960];

% personal exemption 
pexemp = 4050;

% the lower and upper salaries for each bracket for a single filer  
slower = [0, 9325, 37950, 91900, 191650, 416700, 418400];
supper = [9325, 37950, 91900, 191650, 416700, 418400, Inf];

% amount owed from all previous brackets for each bracket for single filer
sowed  = [0, 932.5, 5226.25, 18713.75, 46643.75, 120910.25, 121505.25];

% the lower and upper salaries for each bracket for joint filers
jlower = [0, 18650, 75900, 153100, 233350, 416700, 470700];
jupper = [18650, 75900, 153100, 233350, 416700, 470700, Inf];

% amount owed from all previous brackets for each bracket for joint filers
jowed  = [0, 1865, 10452.50, 29752.50, 52222.50, 112728, 131628];

% single filer deductable and PEASE limit 
sdeduct = 6350;
spep = 384000;

% joint filer deductable and PEASE limit 
jdeduct = 12700;
jpep = 436300;

% example salaries (in K)
salary1 = 70;
salary2 = 100;

% salaries in dollars 
salary1 = salary1*1000;
salary2 = salary2*1000;
jsalary = salary1 + salary2;

% compute joint taxes 
jtax= compute_tax_owed(jsalary, jlower, jupper, rate, jowed, jdeduct, jpep, pexemp);

% compute single taxes 
stax1 = compute_tax_owed(salary1, slower, supper, rate, sowed, sdeduct, spep, pexemp);
stax2 = compute_tax_owed(salary2, slower, supper, rate, sowed, sdeduct, spep, pexemp);

fprintf('Joint Tax           = $%d,%03d\n', ...
    floor(jtax/1000),round(rem(jtax, 1000)) );

fprintf('Single Combined Tax = $%d,%03d\n', ...
    floor( (stax1 + stax2)/1000), round(rem(stax1 + stax2, 1000)) );

%% Difference in Separately-Filed and Joint-Filed Taxes Owed 

salaries = 1:5:200; % [10:10:100, 120, 150, 200, 250, 300, 400];

[X,Y] = meshgrid(salaries,salaries);

Z = zeros(size(X)); 
NS = prod(size(X)); 
for n = 1:NS
    salary1 = X(n)*1000;
    salary2 = Y(n)*1000;
    jsalary = salary1 + salary2;
    
    %compute taxes
    jtax= compute_tax_owed(jsalary, jlower, jupper, rate, jowed, jdeduct, jpep, pexemp);
    stax1 = compute_tax_owed(salary1, slower, supper, rate, sowed, sdeduct, spep, pexemp);
    stax2 = compute_tax_owed(salary2, slower, supper, rate, sowed, sdeduct, spep, pexemp);
    
    % compute difference in taxes (separate minus joint) 
    Z(n) = stax1 + stax2 - jtax; 
end

%% Surface Plot 
h = figure(1); clf; 
h.Position = [99 112 804 587]; 

surf(X, Y, Z); hold on; 
xlabel('first salary(K)'); 
ylabel('second salary(K)'); 
zlabel('separate taxes - joint taxes($)'); 

% add hyperplane at Z = 0 for visualization 
yp = get(gca,'Ylim');
xp = get(gca,'Xlim');
x1 = [ xp(1) xp(2) xp(2) xp(1)];
y1 = [ yp(1) yp(1) yp(2) yp(2)];
z1 = zeros(1,4); 
p = patch(x1,y1,z1, 'b');
set(p,'facealpha',0.2)
set(p,'edgealpha',0.2)

view([5.7 37.2]); 

filenm = 'joint_separate_file_tax_difference_by_salary'; 
print(filenm, '-dpng'); 

