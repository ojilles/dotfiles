#! /bin/bash
#
#  http://justniffer.sourceforge.net/man.htm
#
sudo justniffer -i en1 -u -l "%request.timestamp(%T %D) - %dest.ip:%dest.port [http://%request.header.host/%request.url] -  %response.code %response.size" 