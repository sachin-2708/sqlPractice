-- CIBIL score, often referred to as a credit score, is a numerical representation of an individual's credit worthiness. While the exact formula used by credit bureaus like CIBIL may not be publicly disclosed and can vary slightly between bureaus, the following are some common factors that typically influence the calculation of a credit score:
-- 1- Payment History: This accounts for the largest portion of your credit score. 
 -- It includes factors such as whether you pay your bills on time, any late payments, defaults, bankruptcies, etc.
 -- Assume this accounts for 70 percent of your credit score.

-- 2- Credit Utilization Ratio: This is the ratio of your credit card balances to your credit limits.
 -- Keeping this ratio low (ideally below 30%) indicates responsible credit usage. 
 -- Assume it accounts for 30% of your score and below logic to calculate it: 
 -- Utilization below 30% = 1
 -- Utilization between 30% and 50% = 0.7
 -- Utilization above 50% = 0.5
-- Assume that we have credit card bills data for March 2023 based on that we need to calculate credit utilization ratio. round the result to 1 decimal place.

-- Final Credit score formula = (on_time_loan_or_bill_payment)/total_bills_and_loans * 70 + Credit Utilization Ratio * 30 
-- Display the output in ascending order of customer id.
/*
Table: customers
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| customer_id  | int       |
| credit_limit | int       |
+--------------+-----------+

Table: loans
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| customer_id   | int       |
| loan_id       | int       |
| loan_due_date | date      |
+---------------+-----------+

Table: credit_card_bills
+----------------+-----------+
| COLUMN_NAME    | DATA_TYPE |
+----------------+-----------+
| bill_amount    | int       |
| bill_due_date  | date      |
| bill_id        | int       |
| customer_id    | int       |
+----------------+-----------+

Table: customer_transactions
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| loan_bill_id     | int         |
| transaction_date | date        |
| transaction_type | varchar(10) |
+------------------+-------------+
*/

with combo as
(select customer_id, loan_id, loan_due_date as due_date, 0 as bill_amount 
from loans
union
select customer_id, bill_id, bill_due_date as due_date, bill_amount 
from credit_card_bills),
calculation as(
select c.customer_id, c.loan_id, c.due_date, c.bill_amount, ct.transaction_date,
case when ct.transaction_date <= c.due_date then 'on-time' else 'delayed' end as payment_status
from combo c
inner join customer_transactions ct on c.loan_id = ct.loan_bill_id
inner join customers cu on cu.customer_id = c.customer_id)
,
final_cal as(
select c1.customer_id, sum(bill_amount) as amount,
count(*) as total_bills,
sum(case when payment_status = 'on-time' then 1 else 0 end) as on_time_payment
from calculation c1
inner join customers c2 on c1.customer_id = c2.customer_id
group by customer_id
),
cibil_cal as(
select fc.customer_id,
(on_time_payment/total_bills*70) as time_payment,
sum((case when amount/cc.credit_limit < 0.3 then 1
    when amount/cc.credit_limit < 0.5 then 0.7
    else 0.5 end))*30 as c_utilization
from final_cal fc
inner join customers cc on fc.customer_id = cc.customer_id
group by customer_id)

select customer_id,
round(time_payment+c_utilization,1) as cibil_score
from cibil_cal
