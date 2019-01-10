#!/bin/env python3
from openpyxl import load_workbook
def addMsgStruct(msgl, msg, msgv, msgSt, mda=False):
    memb = 'Cmn';
    msgv = int(msgv)
    if msgSt != "tIPsecCommon":
        if msgSt.startswith('tIPsec'):
            memb = msgSt[len('tIPsec'):]
        else:
            memb = msgSt[1:]
        
    if msgSt in msgl:
        if not msg in msgl[msgSt]['msg']:
            msgl[msgSt]['msg'].append(msg)
        if msgv < msgl[msgSt]['msgv']:
            msgl[msgSt]['msgv'] = msgv
        # overwrite if this struct not for mda only
        if not mda:
            msgl[msgSt]['mda'] = mda
        msgl[msgSt]['memb'] = memb
    else:
        msgl[msgSt] = {'memb': memb, 'msg': [msg], 'msgv': msgv, 'mda':mda}

def genMsgStructCode(msgl):
    padlen = len(max(msgl, key=len))
    tStr = '(this.u.Cmn.MsgType == '
    mdaMarked = False
    # sort msg by (cpm or mda) then by msgv, but put common first
    for struct, msg in sorted(msgl.items(), key=lambda v: (False, 0) if (v[0] == 'tIPsecCommon') else (v[1]['mda'],v[1]['msgv'])):
        if (not mdaMarked) and msg['mda']:
            print(' '.ljust(indent) + '// following are request messages from MDA to CPM')
            mdaMarked = True
        print("%s %s //@Valid:{%s}"%
              (' '.ljust(indent)+struct.ljust(padlen),
               msg['memb'],
               ' || '.join([tStr + m + ')' for m in msg['msg']])
              )
             );


wb = load_workbook(filename='/home/goat/.config/joplin-desktop/resources/33c11edd898b48c3bac292ba7d831a1b.xlsx', read_only=True)
ws = wb['SOCK_IPSEC']
data = tuple(ws.values)
req= {}
resp= {}
indent = 8
# parse data from xlsx file
for row in data[1:]:
    if row[2] != 'N/A':
        addMsgStruct(req, row[0], row[1], row[2])
    if row[3] != 'N/A':
        addMsgStruct(resp, row[0], row[1], row[3])
    if row[4] != 'N/A':
        addMsgStruct(req, row[0], row[1], row[4], True)

# generate code
genMsgStructCode(req)
print(' '.ljust(indent) + '// following are response messages from MDA to CPM')
genMsgStructCode(resp)
