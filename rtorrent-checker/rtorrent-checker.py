#!/usr/bin/python
import argparse, os, shutil, signal, sys, xmlrpclib
import xmlrpc2scgi as xs

def signal_handler(signal, frame):
	print "\n\nAborting...\n"
	sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

parser = argparse.ArgumentParser(description="Check for files that are on your drive, but aren't present in rTorrent", add_help=True)
action = parser.add_mutually_exclusive_group(required=False)
parser.add_argument('path', action="store", help="Directory you want to check")
parser.add_argument('socket', action="store", help="Socket of rTorrent instance you want to check")
action.add_argument('-d', action="store_true", dest="delete", default=False, help="Delete the files")
args = parser.parse_args()

filename = "checker.list"
rtc = xs.RTorrentXMLRPCClient("scgi://"+args.socket)

def find(string, list):
	for item in list:
		if item == string:
			return True
	return False

def refresher():
	torrents = rtc.download_list('')
	numtorr = len(torrents)
	file = open(filename, "w")
	counter = 0
	for torrent in torrents:
		message = rtc.d.get_directory(torrent)
		file.write(unicode(message).encode("utf-8")+"\n")
		counter = counter + 1
		sys.stdout.write("\r"+str(counter)+" / "+str(numtorr)+" ("+str(int(round((100.0*counter)/numtorr)))+"%)")
		sys.stdout.flush()
	file.close()
	sys.stdout.write("\n")

refresher()
torrentlist = []

file = open(filename, "r")
for line in file:
	torrentlist.append(line[:-1])
file.close()

for dirname in os.listdir(args.path):
	path = os.path.join(args.path, dirname)
	if os.path.isdir(path) == True:
		if find(path, torrentlist) == False:
			print "Found: "+os.path.join(args.path, dirname)
			if args.delete:
				shutil.rmtree(path,True)
os.remove(filename)
