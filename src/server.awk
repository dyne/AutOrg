#! /usr/bin/gawk -f
#
# Copyright 2010 Denis Roio <jaromil@dyne.org>
#
# This source code is free software; you can redistribute it and/or
# modify it under the terms of the GNU Public License as published 
# by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.
#
# This source code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# Please refer to the GNU Public License for more details.
#
# You should have received a copy of the GNU Public License along with
# this source code; if not, write to:
# Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA

BEGIN {
  IGNORECASE = 1
  quit     = 0                         # script exits if quit > 0
  port     = 8080                      # port number
  host     = "/inet/tcp/" port "/0/0"  # host string
  url      = "http://localhost:" port  # server url
  status   = 200                       # 200 == OK
  reason   = "OK"                      # server response
  RS = ORS = "\r\n"                    # header line terminators
  doc      = "index.html"              # html default document

  while (!quit) {
      if ($1 == "GET")  doc = substr($2, 2)

      if ($1 == "GET")  page = substr($2, 2)
      if (page == "" )  page = "index.html"
      if( page ~ /html$/) content = "text/html"
      else if( page ~ /jpg$/)  content = "image/jpeg"
      else if( page ~ /png$/)  content = "image/png"
      else if( page ~ /ico$/)  content = "image/x-icon"
      else if( page ~ /pdf$/)  content = "application/pdf"
      else if( page ~ /cmd$/)  content = "exec"
      else if( page ~ /txt$/)  content = "text/plain"
      else content = "invalid"

      if( content != "invalid" ) {
	  if( content == "exec" ) Exec(page)
	  else                    Serve(page)
      }

      if (quit) break
      close(host)     # close client connection
      host |& getline # wait for new client request
  }
  # server terminated...
  close(host)
  exit
}

function Exec(cmd) {
    if ( cmd ~ /quit.cmd/) quit = 1
}

function Serve(page) {

    print "HTTP/5.0", status, reason  |& host
    print "Content-Type:", content    |& host
    print "Connection: Close"         |& host
    page = docroot "/" page
    print docroot "/" page
    if (( getline line < page ) < 0) {
	page = docroot "/error_404.html"
	getline line < page
    } 
    
    print ORS ORS line            |& host
    while ((getline line < page) > 0)
	print line                    |& host
    close(page)
}
