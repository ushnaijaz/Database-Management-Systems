from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from reportlab.lib.colors import yellow, red, black,white
from reportlab.graphics.shapes import Drawing    
from reportlab.graphics.charts.barcharts import VerticalBarChart
from reportlab.graphics import renderPDF

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
c.rect(50*u,83*u,23*u,5*u, stroke=1, fill=0) 
c.rect(50*u,76*u,23*u,5*u, stroke=1, fill=0) 
c.rect(50*u,69*u,23*u,5*u, stroke=1, fill=0) 


height = 730
entries = 0



# for bar-plot

drawing = Drawing(400, 200)
#data = [(13, 5, 20, 22, 37, 45, 19, 4),(14, 6, 21, 23, 38, 46, 20, 5)]
data = [(13, 5, 20, 22)]
bc = VerticalBarChart()    
bc.x = 50    
bc.y = 50    
bc.height = 125    
bc.width = 300    
bc.data = data    
bc.strokeColor = black
bc.valueAxis.valueMin = 0   
bc.valueAxis.valueMax = 30000    
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