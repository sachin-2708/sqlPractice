-- In the field of pharmacovigilance, it's crucial to monitor and assess adverse reactions that patients may experience after taking certain medications.
-- Adverse reactions, also known as side effects, can range from mild to severe and can impact the safety and efficacy of a medication.
-- For each medication, count the number of adverse reactions reported within the first 30 days of the prescription being issued. 
-- Assume that the prescription date in the Prescriptions table represents the start date of the medication usage, display the output in ascending order of medication name.
/*
Table: patients
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| patient_id  | int         |
| name        | varchar(20) |
| age         | int         |
| gender      | varchar(10) |
+-------------+-------------+
Table: medications
+-----------------+-------------+
| COLUMN_NAME     | DATA_TYPE   |
+-----------------+-------------+
| manufacturer    | varchar(20) |
| medication_id   | int         |
| medication_name | varchar(20) |
+-----------------+-------------+
Table: prescriptions
+-------------------+-----------+
| COLUMN_NAME       | DATA_TYPE |
+-------------------+-----------+
| prescription_id   | int       |
| patient_id        | int       |
| medication_id     | int       |
| prescription_date | date      |
+-------------------+-----------+
Table: adverse_reactions
+----------------------+-------------+
| COLUMN_NAME          | DATA_TYPE   |
+----------------------+-------------+
| patient_id           | int         |
| reaction_date        | date        |
| reaction_description | varchar(20) |
| reaction_id          | int         |
+----------------------+-------------+
*/


with cte as
(select pp.medication_id, pp.prescription_date, r.reaction_date 
from prescriptions pp 
left join adverse_reactions r on pp.patient_id = r.patient_id
and r.reaction_date between pp.prescription_date and date_add(pp.prescription_date, interval 30 day))

select m.medication_name, m.manufacturer, 
count(c.reaction_date) as reactions
from medications m
left join cte c on c.medication_id = m.medication_id
group by m.medication_name, m.manufacturer
order by medication_name

-- Alternate Solution

select m.medication_name, m.manufacturer, count(r.reaction_id) as num_adverse_reactions
from medications m
left join prescriptions p on m.medication_id = p.medication_id
left join adverse_reactions r on r.patient_id = p.patient_id
and r.reaction_date between p.prescription_date and date_add(prescription_date, interval 30 day)
group by m.medication_name, m.manufacturer
order by medication_name

