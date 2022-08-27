from google.cloud import bigquery
from google.oauth2 import service_account


credentials = service_account.Credentials.from_service_account_file(
    "db-prj1-b66762db3978.json", scopes=["https://www.googleapis.com/auth/cloud-platform"],
)

client = bigquery.Client(credentials=credentials, project=credentials.project_id,)

if __name__ == "__main__":
    query_job_Q1 = client.query("""
        select inpatient_data.provider_name,inpatient_data.total_inpatients ,outpatient_data.total_outpatients 
 from (select provider_name,sum(total_inpatients)  as total_inpatients from
(SELECT provider_name,count(*) as total_inpatients FROM `bigquery-public-data.medicare.inpatient_charges_2011` group by provider_name
union all
SELECT provider_name,count(*) as total_inpatients FROM `bigquery-public-data.medicare.inpatient_charges_2012` group by provider_name
union all 
SELECT provider_name,count(*) as total_inpatients FROM `bigquery-public-data.medicare.inpatient_charges_2013` group by provider_name
union all 
SELECT provider_name,count(*) as total_inpatients FROM `bigquery-public-data.medicare.inpatient_charges_2014` group by provider_name

) group by provider_name) as inpatient_data
join
(
select provider_name,sum(total_outpatients)  as total_outpatients from
(SELECT provider_name,count(*) as total_outpatients FROM `bigquery-public-data.medicare.outpatient_charges_2011` group by provider_name
union all
SELECT provider_name,count(*) as total_outpatients FROM `bigquery-public-data.medicare.outpatient_charges_2012` group by provider_name
union all 
SELECT provider_name,count(*) as total_outpatients FROM `bigquery-public-data.medicare.outpatient_charges_2013` group by provider_name
union all 
SELECT provider_name,count(*) as total_outpatients FROM `bigquery-public-data.medicare.outpatient_charges_2014` group by provider_name

) group by provider_name

) as outpatient_data
on inpatient_data.provider_name=outpatient_data.provider_name

order by total_inpatients desc

    """)
    result_Q1 = query_job_Q1.result()


    query_job_Q2 = client.query("""
        SELECT nppes_provider_state as state, sum(total_claim_count) total_insurance_claims FROM `bigquery-public-data.medicare.part_d_prescriber_2014` group by nppes_provider_state limit 5

    """)
    result_Q2 = query_job_Q2.result()



    query_job_Q3 = client.query("""
        select sum(all_year_data.diagnostic_condition_count) as total_dgnst_condition_count,all_year_data.drg_definition from (SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2011` group by drg_definition
union all 
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2012` group by drg_definition 
union all
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2013` group by drg_definition 
union all
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2014` group by drg_definition) all_year_data
group by all_year_data.drg_definition order by total_dgnst_condition_count desc
    """)
    result_Q3 = query_job_Q3.result()



    query_job_Q4 = client.query("""
        select sum(all_year_data.diagnostic_condition_count) as total_dgnst_condition_count,all_year_data.drg_definition from (SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2011` group by drg_definition
union all 
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2012` group by drg_definition 
union all
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2013` group by drg_definition 
union all
SELECT count(*) as diagnostic_condition_count,drg_definition FROM `bigquery-public-data.medicare.inpatient_charges_2014` group by drg_definition) all_year_data
group by all_year_data.drg_definition order by total_dgnst_condition_count desc
    """)
    result_Q4 = query_job_Q4.result()



    for row in result_Q3:
         #Row values can be accessed by field name or index.
        print(row[0],row[1])
