#!/usr/bin/python3

'''-----------------------------------------------------------------------------
DESCRIPTION
    This module generates a table of key mappings

USAGE
    python3 tkrdecoder.py [--format table | json ] payload [ payload ... ]

REFERENCE MATERIALS
    * inspired by - https://github.com/papitz/nvim/blob/main/mappings.py
    * argparse: Command-Line Option and Argument Parsing - https://pymotw.com/3/argparse/          # noqa

CREATED BY
    Jeff Irland (jeffskinnerbox@yahoo.com) in May 2023
-----------------------------------------------------------------------------'''

# authorship information
__prog__ = 'gen-table'
__version__ = '0.1'
__status__ = 'Development'
__author__ = 'Jeff Irland'
__maintainer__ = 'Jeff Irland'
__email__ = 'jeffskinnerbox@yahoo.com'
__copyright__ = 'Copyright 2023'
__license__ = 'GNU General Public License'
__python__ = 'Version 3.10.6'
__credits__ = ''



'''-----------------------------------------------------------------------------
DESCRIPTION
    This module provides unit testing routines for
-----------------------------------------------------------------------------'''
# import the necessary packages
# import pytest
import os.path


# test cases for PayloadChecker
CASE3 = [{'challenge': 'maps-test.lua', 'response': True}]
CASE3.append({'challenge': 'maps-test.Lua', 'response': True})
CASE3.append({'challenge': 'maps-test.LUA', 'response': True})
CASE3.append({'challenge': 'maps-test.luax', 'response': False})
CASE3.append({'challenge': 'maps-test.xlua', 'response': False})
CASE3.append({'challenge': 'maps-test.', 'response': False})
CASE3.append({'challenge': 'maps-test', 'response': False})
CASE3.append({'challenge': '.lua', 'response': False})

# execute all the unit tests below
def test_unit():
    test_PayloadChecker()


def test_PayloadChecker():
    for i in range(len(CASE3)):
        value, mess = PayloadChecker(CASE3[i]['challenge'])
        assert value == CASE3[i]['response'], mess


def PayloadChecker(payload):
    '''Check the integrity of the payload for processing
    '''
    # payload file needs to be of type '*.lua'
    if payload == '.lua':
        return False, 'Error: Payload is not a Lua file (aka file type *.lua).'            # noqa
    while payload[-4:] not in ['.lua', '.Lua', '.LUA']:
        return False, 'Error: Payload is not a Lua file (aka file type *.lua).'            # noqa

    return True, 'OK'


def PayloadExist(payload):
    '''Check for the existance of the payload file
    '''
    # payload file must exist
    if not os.path.isfile(payload):
        return False, 'Error: Payload file does not exist.'

    return True, 'OK'


def PayloadParser(payload):
    '''xxx
    '''
    import re

    # check for the existance of the payload file
    rtn, mess = PayloadExist(payload)
    if not rtn:
        return rtn, mess, None

    # check the integrity of the payload file for processing
    rtn, mess = PayloadChecker(payload)
    if not rtn:
        return rtn, mess, None

    # regular expresions used to capture title of key-mapping group and the mapping
    titleRegex = "^-- (.*)"
    mapRegex = "\wmap\(\"(.*?)\", \"(.*?)\"\)"

    # open the payload file to be parsed
    file = open(payload, "r")


    # move through the lines of the file capturing the key-mappings
    payload_parsed = { 'file': payload, 'content': {} }
    idx = 0
    for line in file:
        if re.search(titleRegex, line):
            jdx = 0
            match = re.search(titleRegex, line)
            print("\n")
            print("#### " + match.group(1) + "\n")
            print("| Key | Function |\n")
            print("|-----|----------|\n")
            string = 'group' + str(idx)
            obj2 = { "title": match.group(1), 'rows': {} }
            payload_parsed['content']['number'] = idx + 1
            idx += 1
        elif re.search(mapRegex, line):
            match = re.search(mapRegex, line)
            print("| " + match.group(1).replace("<", "\\<").replace(">", "\\>") +
                 " | " + match.group(2).replace("<", "\\<").replace(">", "\\>") + " | \n")
            obj3 = { 'key': match.group(1), 'function': match.group(2), 'description': "" }
            obj2['rows']['number'] = jdx + 1
            obj2['rows']['row' + str(jdx)] = obj3
            payload_parsed['content'][string] = obj2
            jdx += 1

    return True, 'OK', payload_parsed


'''-----------------------------------------------------------------------------
DESCRIPTION
    This script decodes the payload delivered by the Link Labs GPS Tracker.
-----------------------------------------------------------------------------'''
if __name__ == '__main__':
    # import the necessary packages
    import sys
    import json
    import argparse

    # perform unit testing
    test_unit()

    # default delimiter for csv format
    DELIMITER = ','

    def LineArgumentParser():
        '''Construct the commandline argument parser, add the rules for the
        arguments, and then parse the arguments (found in sys.argv).
        '''
        # output format options
        list1 = ['table', 'json', 'csv']
        list2 = ['gps', 'reg', 'all']

        ap = argparse.ArgumentParser(
            prog=__prog__,
            formatter_class=argparse.RawTextHelpFormatter,
            description='This program parses and re-formats key-mapping statements within the NeoVim configuration files.\n'  # noqa
            + 'The new formatting is as a Markdown table, or as comma separated values (CVS), or JSON format.'
            + 'The default format is the Markdown table which looks like this:'
            + '\n\n'
            + '#### Split panel\n'
            + '| Key | Function |\n'
            + '|-----|----------|\n'
            + '| \<leader\>v | \<C-w\>v |\n'
            + '| \<leader\>ws | \<C-w\>s |\n'
            + '\n'
            + '#### Markdown Preview control\n'
            + '| Key | Function |\n'
            + '|-----|----------|\n'
            + '| \<leader\>m | :MarkdownPreview\<CR\> |\n'
            + '\n'
            + '#### map spelling\n'
            + '| Key | Function |\n'
            + '|-----|----------|\n'
            + '| \<F8\> | :setlocal spell spelllang=de,en \<return\> |\n'
            + '| \<F9\> | :set nospell \<return\> |\n'
            + '\n\n'
            + 'and the above resulted from parsing & reformating the following text in the Lua files:\n'
            + '\n\n'
            + '-- Split panel\n'
            + 'nmap("<leader>v", "<C-w>v")\n'
            + 'nmap("<leader>ws", "<C-w>s")\n'
            + '\n'
            + '-- Markdown Preview control\n'
            + 'nmap("<leader>m", ":MarkdownPreview<CR>")\n'
            + '\n'
            + '-- map spelling\n'
            + 'nmap("<F8>", ":setlocal spell spelllang=de,en <return>")\n'
            + 'nmap("<F9>", ":set nospell <return>")\n',
            epilog='Design details provided by the Link Labs team (www.link-labs.com).')                       # noqa

        ap.add_argument('-f', '--format',
                        required=False,
                        choices=list1,
                        default='json',
                        help='format of the output with allowed values of \'' +
                        '\', \''.join(list1) + '\'.',
                        metavar='')

        ap.add_argument('-m', '--message',
                        required=False,
                        choices=list2,
                        default='gps',
                        help='message types inthe output with allowed values of \'' +                  # noqa
                        '\', \''.join(list2) + '\'.',
                        metavar='')

        ap.add_argument('payload',
                        nargs='+',
                        help='payload(s) from the Link Labs Cat-M1 GPS Tracker')

        ap.add_argument('-d', '--delimiter',
                        required=False,
                        default=DELIMITER,
                        help='delimiter used in the csv format.')

        ap.add_argument('--version', action='version',
                        version='%(prog)s 0.0')

        return vars(ap.parse_args())


    def PrintTable(parsedpayload):
        print("NOT IMPLEMENT YET!")


    def PrintCSV(parsedpayload):
        print("NOT IMPLEMENT YET!")


    def PrintJSON(parsedpayload):
        print(json.dumps(decoded_payload, indent='   '))


    # parse the commandline arguments
    args = LineArgumentParser()
    print('commandline arguments = ', args, file=sys.stderr)

    # decode payloads from the commandline
    for pl in args['payload']:
        rtn, mess, decoded_payload = PayloadParser(pl)    # returns dictionary
        if not rtn:
            print(mess + '  Payload = ' + pl, file=sys.stderr)
            exit(1)

        # print a formated output of the payload strings
        if args['format'] == 'table':
            PrintTable(decoded_payload)                    # print table format
        elif args['format'] == 'csv':
            PrintCSV(decoded_payload)                      # print csv format
        else:
            PrintJSON(decoded_payload)                     # print json format

