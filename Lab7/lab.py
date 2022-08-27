from google.cloud import bigquery
from google.oauth2 import service_account
credentials = service_account.Credentials.from_service_account_file(
'C:/Users/user/Documents/parhai/6th semester/DBMS/lab/lab7/ce-39-project1submission-da4458905b80.json')

project_id = 'ce-39-project1submission'
client = bigquery.Client(credentials= credentials,project=project_id)