#
# This is taken straight from http://stackoverflow.com/questions/4296249/how-do-i-convert-a-hex-triplet-to-an-rgb-tuple-and-back
#
#
_NUMERALS = '0123456789abcdefABCDEF'
#_HEXDEC = {v: int(v, 16) for v in x+y for x in _NUMERALS for y in _NUMERALS}

_HEXDEC = {}
for y in _NUMERALS:
    for x in _NUMERALS:
        v = x+y
        _HEXDEC.update({v: int(v,16)})

LOWERCASE, UPPERCASE = 'x', 'X'

def rgb(triplet):
    return _HEXDEC[triplet[0:2]], _HEXDEC[triplet[2:4]], _HEXDEC[triplet[4:6]]

def triplet(rgb, lettercase=LOWERCASE):
    return format(rgb[0]<<16 | rgb[1]<<8 | rgb[2], '06'+lettercase)

if __name__ == '__main__':
    print('{}, {}'.format(rgb('aabbcc'), rgb('AABBCC')))
    # -> (170, 187, 204), (170, 187, 204)

    print('{}, {}'.format(triplet((170, 187, 204)),
                          triplet((170, 187, 204), UPPERCASE)))
    # -> aabbcc, AABBCC

    print('{}, {}'.format(rgb('aa0200'), rgb('AA0200')))
    # -> (170, 2, 0), (170, 2, 0)

    print('{}, {}'.format(triplet((170, 2, 0)),
                          triplet((170, 2, 0), UPPERCASE)))
