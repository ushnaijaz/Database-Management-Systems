from google.cloud import bigquery
from google.oauth2 import service_account

from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib.colors import yellow, red, black,white
from reportlab.graphics.shapes import Drawing    
from reportlab.graphics.charts.barcharts import VerticalBarChart
from reportlab.graphics import renderPDF



credentials = service_account.Credentials.from_service_account_file(
    "db-prj1-b66762db3978.json", scopes=["https://www.googleapis.com/auth/cloud-platform"],
)

client = bigquery.Client(credentials=credentials, project=credentials.project_id,)

if __name__ == "__main__":
    query_job_Q5_i = client.query("""
        SELECT
  COUNT(*)+(
  SELECT
    COUNT(*)+(
    SELECT
      COUNT(*)+(
      SELECT
        COUNT(*) AS renal_count4
      FROM
        `bigquery-public-data.medicare.inpatient_charges_2014`
      WHERE
        drg_definition LIKE '%RENAL FAILURE%') AS renal_count3
    FROM
      `bigquery-public-data.medicare.inpatient_charges_2013`
    WHERE
      drg_definition LIKE '%RENAL FAILURE%' ) AS renal_count2
  FROM
    `bigquery-public-data.medicare.inpatient_charges_2012`
  WHERE
    drg_definition LIKE '%RENAL FAILURE%' ) AS total_renal_count
FROM
  `bigquery-public-data.medicare.inpatient_charges_2011`
WHERE
  drg_definition LIKE '%RENAL FAILURE%'

    """)
    total_inpatients = query_job_Q5_i.result()


    query_job_Q5_ii = client.query("""
        SELECT
  COUNT(*)+(
  SELECT
    COUNT(*)+(
    SELECT
      COUNT(*)+(
      SELECT
        COUNT(*) AS renal_count4
      FROM
        `bigquery-public-data.medicare.outpatient_charges_2014`
      WHERE
        apc LIKE '%RENAL FAILURE%') AS renal_count3
    FROM
      `bigquery-public-data.medicare.outpatient_charges_2013`
    WHERE
      apc LIKE '%RENAL FAILURE%' ) AS renal_count2
  FROM
    `bigquery-public-data.medicare.outpatient_charges_2012`
  WHERE
    apc LIKE '%RENAL FAILURE%' ) AS total_renal_count
FROM
  `bigquery-public-data.medicare.outpatient_charges_2011`
WHERE
  apc LIKE '%RENAL FAILURE%'

    """)
    total_outpatients = query_job_Q5_ii.result()



    query_job_Q5_iii = client.query("""
        SELECT
  sum(average_total_payments)+(
  SELECT
    sum(average_total_payments) +(
    SELECT
      sum(average_total_payments)+(
      SELECT
        sum(average_total_payments) AS payment4
      FROM
        `bigquery-public-data.medicare.inpatient_charges_2014`
      WHERE
        drg_definition LIKE '%RENAL FAILURE%') AS payment3
    FROM
      `bigquery-public-data.medicare.inpatient_charges_2013`
    WHERE
      drg_definition LIKE '%RENAL FAILURE%' ) AS payment2
  FROM
    `bigquery-public-data.medicare.inpatient_charges_2012`
  WHERE
    drg_definition LIKE '%RENAL FAILURE%' ) AS total_avg_payment
FROM
  `bigquery-public-data.medicare.inpatient_charges_2011`
WHERE
  drg_definition LIKE '%RENAL FAILURE%'

    """)
    total_inpatients_avg_amount = query_job_Q5_iii.result()




    query_job_Q5_iv = client.query("""
        SELECT
  sum(average_total_payments)+(
  SELECT
    sum(average_total_payments) +(
    SELECT
      sum(average_total_payments)+(
      SELECT
        sum(average_total_payments) AS payment4
      FROM
        `bigquery-public-data.medicare.outpatient_charges_2014`
      WHERE
        apc LIKE '%RENAL FAILURE%') AS payment3
    FROM
      `bigquery-public-data.medicare.outpatient_charges_2013`
    WHERE
      apc LIKE '%RENAL FAILURE%' ) AS payment2
  FROM
    `bigquery-public-data.medicare.outpatient_charges_2012`
  WHERE
    apc LIKE '%RENAL FAILURE%' ) AS total_avg_payment
FROM
  `bigquery-public-data.medicare.outpatient_charges_2011`
WHERE
  apc LIKE '%RENAL FAILURE%'

    """)
    total_outpatients_avg_amount = query_job_Q5_iv.result()



# for plot

  
    query_job_Q5_2014 = client.query("""
        SELECT
        sum(average_total_payments) AS payment_released4
      FROM
        `bigquery-public-data.medicare.inpatient_charges_2014`
      WHERE
        drg_definition LIKE '%RENAL FAILURE%'

    """)
    payment_released_2014 = query_job_Q5_2014.result()


  
    query_job_Q5_2013 = client.query("""
       SELECT
      sum(average_total_payments)
    FROM
      `bigquery-public-data.medicare.inpatient_charges_2013`
    WHERE
      drg_definition LIKE '%RENAL FAILURE%'

    """)
    payment_released_2013= query_job_Q5_2013.result()



    
    query_job_Q5_2012 = client.query("""
         SELECT
        sum(average_total_payments) AS payment_released12
      FROM
        `bigquery-public-data.medicare.inpatient_charges_2012`
      WHERE
        drg_definition LIKE '%RENAL FAILURE%'

    """)
    payment_released_2012 = query_job_Q5_2012.result()


    
    query_job_Q5_2011 = client.query("""
         SELECT
        sum(average_total_payments) AS payment_released12
      FROM
        `bigquery-public-data.medicare.inpatient_charges_2011`
      WHERE
        drg_definition LIKE '%RENAL FAILURE%'

    """)
    payment_released_2011 = query_job_Q5_2011.result()





    """ for row in result_Q5:
         #Row values can be accessed by field name or index.
        print(row[0],row[1]) """

   

    """ for row in result_Q5:
        if (entries == 35):
            c.showPage()
            c.drawString(10, 750, "Column A")
            c.drawString(275, 750, "Column B")
            height = 730
            entries = 0

        c.drawString(10, height, row.game_id)
        c.drawString(275, height, str(row.season))
        height = height - 20
        entries = entries + 1

    c.save() """

for row in total_inpatients:
  total_inpatients=row[0]
  break
for row in total_outpatients:
  total_outpatients=row[0]
  break
for row in total_inpatients_avg_amount:
  total_inpatients_avg_amount=row[0]
  break
for row in total_outpatients_avg_amount:
  total_outpatients_avg_amount=row[0]
  break

# for plots

for row in payment_released_2011:
  payment_released_2011=row[0]
  break
for row in payment_released_2012:
  payment_released_2012=row[0]
  break
for row in payment_released_2013:
  payment_released_2013=row[0]
  break
for row in payment_released_2014:
  payment_released_2014=row[0]
  break


""" print(total_inpatients)
print(total_outpatients)
print(total_inpatients_avg_amount)
print(total_outpatients_avg_amount) """

#pdf code


c = canvas.Canvas("q5.pdf")

u=inch/10


c.rect(20*u,100*u,40*u,10*u, stroke=1, fill=0)    
c.setFillColor(black)
c.drawString(180, 750, "Payment Details for Patients with Renal Failure")

c.rect(10*u,90*u,23*u,5*u, stroke=1, fill=0) 
c.drawString(11*u, 93*u, "Total in-patients in all MCs")
c.rect(10*u,83*u,23*u,5*u, stroke=1, fill=0)
c.drawString(11*u, 86*u, "Total out-patients in all MCs") 
c.rect(10*u,76*u,23*u,5*u, stroke=1, fill=0)
c.drawString(11*u, 79*u, "Tot. avg amount paid to inpat.") 
c.rect(10*u,69*u,23*u,5*u, stroke=1, fill=0) 
c.drawString(11*u, 72*u, "Tot. avg amnt paid to outpat.") 

c.rect(50*u,90*u,23*u,5*u, stroke=1, fill=0)
c.drawString(51*u, 93*u, str(total_inpatients)) 
c.rect(50*u,83*u,23*u,5*u, stroke=1, fill=0)
c.drawString(51*u, 86*u, str(total_outpatients)) 
c.rect(50*u,76*u,23*u,5*u, stroke=1, fill=0)
c.drawString(51*u, 79*u, str(total_inpatients_avg_amount)) 
c.rect(50*u,69*u,23*u,5*u, stroke=1, fill=0)
c.drawString(51*u, 72*u, str(total_outpatients_avg_amount)) 


height = 730
entries = 0



# for bar-plot

drawing = Drawing(400, 200)
#data = [(13, 5, 20, 22, 37, 45, 19, 4),(14, 6, 21, 23, 38, 46, 20, 5)]
data = [(payment_released_2011, payment_released_2012, payment_released_2013, payment_released_2014)]
bc = VerticalBarChart()    
bc.x = 50    
bc.y = 50    
bc.height = 125    
bc.width = 300    
bc.data = data    
bc.strokeColor = black
bc.valueAxis.valueMin = 0   
bc.valueAxis.valueMax = 300000    
bc.valueAxis.valueStep = 5000
#bc.categoryAxis.labels.boxAnchor = 'ne'    
#bc.categoryAxis.labels.dx = 8    
#bc.categoryAxis.labels.dy = -2    
#bc.categoryAxis.labels.angle = 30    
bc.categoryAxis.categoryNames = ['Renal Failure']
drawing.add(bc)

renderPDF.draw(drawing, c, 99, 99, showBoundary=True)
#c.drawImage(drawing,10,10,80,89)


c.save()