#! /usr/bin/gawk -f 
BEGIN {
  IGNORECASE = 1
  x        = 1                         # script exits if x < 1
  port     = 8080                      # port number
  host     = "/inet/tcp/" port "/0/0"  # host string
  url      = "http://localhost:" port  # server url
  status   = 200                       # 200 == OK
  reason   = "OK"                      # server response
  RS = ORS = "\r\n"                    # header line terminators
  doc      = "index.html"              # html default document

  while (x) {
      if ($1 == "GET")
	  doc = substr($2, 2)
      if (! x) break
      Serve(doc, host)
      close(host)     # close client connection
      host |& getline # wait for new client request
  }
  # server terminated...
  doc = "<html>\
  <head><title>AutOrg Terminated</title></head>	\
  <body><p>AutOrg HTTP daemon is off.</body>	\
  </html>"
  Serve(doc, host)
  close(host)
  exit
}

function Serve(page,host) {

    if( page ~ /html$/) content = "text/html"
    else if( page ~ /jpg$/)  content = "image/jpeg"
    else if( page ~ /png$/)  content = "image/png"
    else if( page ~ /pdf$/)  content = "application/pdf"
    else content = "text/plain"

    print "HTTP/1.1", status, reason  |& host
    print "Content-Type:", content    |& host
    print "Connection: Close"         |& host
    getline line < page
    print ORS line                    |& host
    while ((getline line < page) > 0)
	print line                    |& host
    close(page)
}
