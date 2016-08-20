#!/usr/bin/python

from xml.dom.minidom import parse
import xml.dom.minidom

game = raw_input('Enter a game name: 1 - Lotto. 2 - 777: ')
print('game name is ' + game)

if game == '1':
	print('You choosed lotto')
	game = 'lotto'
elif game == '2':
	print('You choosed 777')
	game = '777'
else:
	print('Incorrect entering. Program is terminated')
	exit()

paid = int(raw_input('How much was paid for game ' + game + '?'))
print 'For game %s was paid %d' %(game, paid)
revenue = int(raw_input('What is revenue did you get? ')) 

print 'Parsing XML file'
# Open XML document using minidom parser
DOMTree = xml.dom.minidom.parse("revenue_template.xml")
event = DOMTree.documentElement
if event.hasAttribute("shelf"):
   print "Root element : %s" % event.getAttribute("shelf")

# Get all dates in the event
dates = event.getElementsByTagName("Date")



