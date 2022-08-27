from google.cloud import bigquery
from google.oauth2 import service_account
from reportlab.pdfgen import canvas
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

credentials = service_account.Credentials.from_service_account_file(
"C:/Users/user/Documents/parhai/6th semester/DBMS/lab/lab7/db-prj1-b66762db3978.JSON")

project_id = 'ce-39-project1submission'
client = bigquery.Client(credentials= credentials,project=project_id)



if __name__ == "__main__":
    c = canvas.Canvas("DBLab7_Graphs_2019_CE_39.pdf")
    c.rect(65, 710, 470, 80, stroke=1, fill=0)
    c.setFont("Helvetica-Bold", 18)
    c.drawString(80, 740, "Payment Details for Patients with Renal Failure")
    c.setFont("Helvetica", 12)

    c.rect(50, 620, 180, 40, stroke=1, fill=0)
    c.rect(50, 570, 180, 40, stroke=1, fill=0)
    c.rect(50, 520, 180, 40, stroke=1, fill=0)
    c.rect(50, 470, 180, 40, stroke=1, fill=0)

    #rectangles at right
    c.rect(380, 620, 180, 40, stroke=1, fill=0)
    c.rect(380, 570, 180, 40, stroke=1, fill=0)
    c.rect(380, 520, 180, 40, stroke=1, fill=0)
    c.rect(380, 470, 180, 40, stroke=1, fill=0)

    c.setFont("Helvetica", 9)    
    c.drawString(60, 650,"Total number of in-patients in all")
    c.drawString(60, 630, "medical centers")
    c.drawString(60, 550, "Total average amount paid")
    c.drawString(60, 530, "to inpatients")

    c.drawString(60, 600, "Total number of outpatients in all")
    c.drawString(60, 580, "medical centers")
    c.drawString(60, 500, "Total average amount paid")
    c.drawString(60, 480, "to outpatients")

    c.setFont("Helvetica", 12)


    query1 = client.query("""
        SELECT sum(total_inpatients) AS total_inpatients_with_renal_failure,sum(TOTAL_amount_paid) AS total_average_amount
        FROM (SELECT SUM(total_discharges) AS TOTAL_inpatients,SUM(average_medicare_payments) AS TOTAL_amount_paid FROM `bigquery-public-data.cms_medicare.inpatient_charges_2011` WHERE drg_definition like '%RENAL FAILURE%'
              GROUP BY provider_name,drg_definition
              UNION DISTINCT
              SELECT SUM(total_discharges) AS TOTAL_inpatients,SUM(average_medicare_payments) AS TOTAL_amount_paid  FROM `bigquery-public-data.cms_medicare.inpatient_charges_2012` WHERE drg_definition like '%RENAL FAILURE%'
              GROUP BY provider_name,drg_definition
              UNION DISTINCT
              SELECT SUM(total_discharges) AS TOTAL_inpatients,SUM(average_medicare_payments) AS TOTAL_amount_paid FROM `bigquery-public-data.cms_medicare.inpatient_charges_2013` WHERE drg_definition like '%RENAL FAILURE%'
              GROUP BY provider_name,drg_definition
              UNION DISTINCT
              SELECT SUM(total_discharges) AS TOTAL_inpatients,SUM(average_medicare_payments) AS TOTAL_amount_paid FROM `bigquery-public-data.cms_medicare.inpatient_charges_2014` WHERE drg_definition like '%RENAL FAILURE%'
              GROUP BY provider_name,drg_definition
              UNION DISTINCT
              SELECT SUM(total_discharges) AS TOTAL_inpatients,SUM(average_medicare_payments) AS TOTAL_amount_paid FROM `bigquery-public-data.cms_medicare.inpatient_charges_2015` WHERE drg_definition like '%RENAL FAILURE%'
              GROUP BY provider_name,drg_definition )
        LIMIT 1000
    """)

    results1 = query1.result()
    
    for row in results1:
        c.drawString(410, 640,str(row.total_inpatients_with_renal_failure))
        c.drawString(410,540,str(row.total_average_amount))


    query_outpatients = client.query("""
        SELECT IFNULL(SUM(total_outpatients),0) AS total_outpatients_with_renal_failure,IFNULL(SUM(average_payment),0) as total_average_payment
        FROM (SELECT SUM(outpatient_services) AS total_outpatients,IFNULL(SUM(average_total_payments),0) as average_payment FROM `bigquery-public-data.cms_medicare.outpatient_charges_2011` WHERE apc like '%RENAL FAILURE%'
              GROUP BY apc
              UNION DISTINCT
              SELECT SUM(outpatient_services) AS total_outpatients,IFNULL(SUM(average_total_payments),0) as average_payment  FROM `bigquery-public-data.cms_medicare.outpatient_charges_2012` WHERE apc like '%RENAL FAILURE%'
              GROUP BY apc
              UNION DISTINCT
              SELECT SUM(outpatient_services) AS total_outpatients,IFNULL(SUM(average_total_payments),0) as average_payment FROM `bigquery-public-data.cms_medicare.outpatient_charges_2013` WHERE apc like '%RENAL FAILURE%'
              GROUP BY apc
              UNION DISTINCT
              SELECT SUM(outpatient_services) AS total_outpatients,IFNULL(SUM(average_total_payments),0) as average_payment FROM `bigquery-public-data.cms_medicare.outpatient_charges_2014` WHERE apc like '%RENAL FAILURE%'
              GROUP BY apc
              UNION DISTINCT
              SELECT SUM(outpatient_services) AS total_outpatients,IFNULL(SUM(average_total_payments),0) as average_payment FROM `bigquery-public-data.cms_medicare.outpatient_charges_2015` WHERE apc like '%RENAL FAILURE%'
              GROUP BY apc )
        LIMIT 1000


    """)
    
    results2 = query_outpatients.result()

    for row in results2:
        c.drawString(410, 590,str(row.total_outpatients_with_renal_failure))
        c.drawString(410,490,str(row.total_average_payment))

    query3 = client.query("""
    Select total_payments
    FROM (
    SELECT SUM(average_covered_charges)  as total_payments
    FROM `bigquery-public-data.cms_medicare.inpatient_charges_2011`
    UNION DISTINCT
    SELECT SUM(average_covered_charges)  as total_payments
    FROM `bigquery-public-data.cms_medicare.inpatient_charges_2012`
    UNION DISTINCT
    SELECT SUM(average_covered_charges)  as total_payments
    FROM `bigquery-public-data.cms_medicare.inpatient_charges_2013`
    UNION DISTINCT 
    SELECT SUM(average_covered_charges)  as total_payments
    FROM `bigquery-public-data.cms_medicare.inpatient_charges_2014`
   )
    """)

    results3 = query3.result()

    
    # Changeingcolors 
    c.setStrokeColorRGB(0.5, 0.5, 0)
    c.rect(50, 690, 500, 110, stroke=1, fill=0)  
    c.setStrokeColorRGB(0, 0, 0)


    c.save()
    
    payments = list()
    
    for r in results3:
        payments.append(int(r.total_payments))
    with PdfPages('DBLab7_PatientInfo_2019_CE_39.pdf') as export_pdf:
        label = ["2011","2012","2013","2014"]
        plt.bar(label,payments,width=1,color=['Blue','orange','grey','yellow'])
        export_pdf.savefig()
        plt.close()

    