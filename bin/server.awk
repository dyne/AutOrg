#.H1 A Web Server in Awk
#.P
# Server.awk - a simple, single user, web server built with gawk.
#.H2 Download
#.P 
#Download from
#.URL http://lawker.googlecode.com/svn/fridge/lib/awk/server.awk LAWKER.
#.H2 About
#.P
#This code
# creates an html menu of local applications which you can season to taste.
# The usage requires two steps... 
#.OL
#.LI run: 'gawk -f server.awk' 
#.LI open browser at: http://localhost:8080 
#./OL
#.P
#This code is
# based on the examples located at the 
# <a href="http://www.gnu.org/software/gawk/manual/gawkinet/gawkinet.html">TCP/IP Internetworking With `gawk'</a> manual
#and is licensed under 
# <a href="http://www.gnu.org/licenses/gpl-3.0-standalone.html">GPL 3.0</a>. For
# updates to thos code, see
#<a href="http://topcat.hypermart.net/index.html">http://topcat.hypermart.net/index.html</a>.
#.H2 Code
#.H3 Set up
#.SMALL
#.PRE
BEGIN { 
  x        = 1                         # script exits if x < 1 
  port     = 8080                      # port number 
  host     = "/inet/tcp/" port "/0/0"  # host string 
  url      = "http://localhost:" port  # server url 
  status   = 200                       # 200 == OK 
  reason   = "OK"                      # server response 
  RS = ORS = "\r\n"                    # header line terminators 
  doc      = Setup()                   # html document 
  len      = length(doc) + length(ORS) # length of document 
  while (x) { 
     if ($1 == "GET") RunApp(substr($2, 2)) 
     if (! x) break   
     print "HTTP/1.0", status, reason |& host 
     print "Connection: Close"        |& host 
     print "Pragma: no-cache"         |& host 
     print "Content-length:", len     |& host 
     print ORS doc                    |& host 
     close(host)     # close client connection 
     host |& getline # wait for new client request 
  } 
  # server terminated... 
  doc = Bye() 
  len = length(doc) + length(ORS) 
  print "HTTP/1.0", status, reason |& host 
  print "Connection: Close"        |& host 
  print "Pragma: no-cache"         |& host 
  print "Content-length:", len     |& host 
  print ORS doc                    |& host 
  close(host) 
} 
#./PRE
#.H3 HTML Menu
#.PRE
function Setup() { 
  tmp = "<html>\
  <head><title>Simple gawk server</title></head>\
  <body>\
  <p><a href=" url "/xterm>xterm</a>\
  <p><a href=" url "/xcalc>xcalc</a>\
  <p><a href=" url "/xload>xload</a>\
  <p><a href=" url "/exit>terminate script</a>\
  </body>\
  </html>" 
  return tmp 
} 
#./PRE
#.H3 Saying Good-bye
#.PRE
function Bye() { 
  tmp = "<html>\
  <head><title>Simple gawk server</title></head>\
  <body><p>Script Terminated...</body>\
  </html>" 
  return tmp 
} 
#./PRE
#.H3 Running Applications
#.PRE
function RunApp(app) { 
  if (app == "xterm")  {system("xterm&"); return} 
  if (app == "xcalc" ) {system("xcalc&"); return} 
  if (app == "xload" ) {system("xload&"); return} 
  if (app == "exit")   {x = 0} 
}
#./PRE
#./SMALL
#.H2 Author
#.P
#Michael Sanders
