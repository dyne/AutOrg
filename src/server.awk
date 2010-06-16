BEGIN { 
  x        = 1                         # script exits if x < 1 
  port     = 8080                      # port number 
  host     = "/inet/tcp/" port "/0/0"  # host string 
  url      = "http://localhost:" port  # server url 
  status   = 200                       # 200 == OK 
  reason   = "OK"                      # server response 
  RS = ORS = "\r\n"                    # header line terminators 
  doc      = page                      # html document 
  len      = length(doc) + length(ORS) # length of document 
  while (x) { 
     if ($1 == "GET") Get(substr($2, 2)) 
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
  exit
} 

function Bye() { 
  tmp = "<html>\
  <head><title>Simple gawk server</title></head>\
  <body><p>Script Terminated...</body>\
  </html>" 
  return tmp 
} 

function Get(file) { 
    if(index(file,".html")!=0) {
	print file
	x = 0
    }
}
EOF
