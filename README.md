# Separate Versus Joint Filing

This code computes the difference in federal income taxes for joint filing versus separate filing for a couple where each partner has a salary between 1K and 200K. The code makes extremely basic tax assumptions (no dependents, no itemized deductions, no scholarships, no witholdings, no educational expenses, no retirment contributions, not a home owner, not self-employed, no other taxable income). 

The code uses the tax brackets defined on the [tax foundation website](https://taxfoundation.org/2017-tax-brackets/) and takes into account Personal Exemptions, Standard Deductions, and Pease Limitations. The code does not take into account the Alternative Minimum Tax Exemption nor Earned Income Tax Credits. 

![surface plot of difference in taxes owed for separate filing versus joing filing](https://github.com/geebioso/TaxBrackets/blob/master/joint_separate_file_tax_difference_by_salary.png)

## Trump Tax Plan 

The function `new_old_taxes.m` computes the net income for a University of California graduate student assuming just basic tax brackets under the current (November 2017) tax brackets and the proposed senate tax brackets. The code assumes that the student is a resident of California. 

![net income now versus under trump tax plan for UC graduate students](https://github.com/geebioso/TaxBrackets/blob/master/income_now_vs_tax_cut.png)
