import json
import sys
from os import mkdir
from os.path import isdir


def main():
	string = sys.stdin.readline()
	data = json.loads(string)
	dirname = './'+data['incident_number']+'/'
	
	args = set()
	for arg in sys.argv:
		args.add(arg)
	args.remove(sys.argv[0])  # there is no necessity for the name to be in arguments set

	if not isdir(dirname):
		mkdir(dirname)
	elif not '-f' in args and not '--force' in args:
		sys.stdout.write('Directory ' + dirname + 'already exists... If you want to overwrite it use the -f argument\n')
		return -1

	with open(dirname+data['incident_number'], 'w') as file:
		file.write(data['incident_number'] + '\n\n')
		file.write('Customer Number: ' + data['cust_number'] + '\n')
		file.write('Customer Name: ' + data['name'] + '\n')
		file.write('url: ' + data['url'] + '\n')
		file.write('short_description: ' + '\n')
		file.write('installation: ' + '\n')
		file.write('System ID: ' + data['sysid'] + '\n')
		file.write('client: ' + '\n')
		file.write('user: ' + '\n')
		file.write('pass: ' + '\n')
		file.write('\n[ ] legacy HCI    [ ] legacy BOOMI    [ ] BIB    [ ] PTP    [ ] S/4 Cloud\n')
		file.write('test employee -> pernr: | ext_id: \n')

		sys.stdout.write('file ' + data['incident_number'] + ' created\n')
		return 0
		# test string
		# {"incident_ID":["0020751295","0000127345","2018"],"url":"https://support.wdf.sap.corp/sap/support/message/002075129500001273452018","incident_number":"127345 2018","name":"Kerry Group Services International Ltd","cust_number":"623114","sysid":"E7D"}


if __name__ == "__main__":
	main()
