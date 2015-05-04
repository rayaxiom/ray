#!/usr/bin/env python

import sys

# To run ssh
import subprocess as subp

# For automated browser
import mechanize

# For getting ip and time
import socket
import time

def get_ip():
    """Taken from stackoverflow.
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("gmail.com", 80))
    myip = s.getsockname()[0]
    s.close()

    return myip.split(".")

# Take time as an input because server time is wrong by a few minutes, need
# to extract it from the html.
def construct_code(their_time):
    ip = get_ip()
    minute = their_time.split(":")[1]
    return ip[3] + str(minute) + ip[1]


def main():

    br = mechanize.Browser()
    
    # Go to the website
    response = br.open("http://www.maths.manchester.ac.uk/ip.php")    

    # Select the form
    br.select_form(nr=0)

    # Construct the code
    code = construct_code(br["now"])
    print code
    
    # enter the code    
    br.set_value(code, name="code")
    br.submit()


    # wait for the server to recognise and add us to the allowed list
    time.sleep(2)

    # Finally ssh into maths1 and background it so that we can connect whenever
    subp.check_call(["ssh", "maths1", "-f", "-N"])

    # Done
    return 0


if __name__ == "__main__":
    sys.exit(main())
