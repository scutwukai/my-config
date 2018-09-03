#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os
import sys
import optparse

from os.path import isfile, expanduser
from datetime import datetime, date

DB = "test"
OUT = "dump.txt"


def run(opts, args):
    fpath = expanduser(opts.out)
    if isfile(fpath) and not opts.force:
        sys.stderr.write("%s is exists, use -f or --force to overwrite.\n" % fpath)
        sys.exit(-1)

    fp = open(fpath, "wb")

    print "input the sql below, use ^D to terminate, or quit by ^C."
    print "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    sql = sys.stdin.read()

    print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    sys.stdout.write("inputs are accepted. querying......")

    import ConfigParser
    config = ConfigParser.RawConfigParser(allow_no_value=True)
    config.read(expanduser("~/.my.cnf"))

    import mysql.connector
    conn = mysql.connector.connect(
        host=config.get("client", "host"),
        port=int(config.get("client", "port")),
        user=config.get("client", "user"),
        passwd=config.get("client", "password"),
        charset="utf8",
        db=opts.db,
    )
    conn.autocommit = True

    cursor = conn.cursor()
    cursor.execute(sql, ())
    data = cursor.fetchall()
    cursor.close()

    conn.close()
    sys.stdout.write("done! writing files......")

    for row in data:
        line = []
        for col in row:
            if isinstance(col, datetime):
                line.append(col.strftime("%Y-%m-%d %H:%M:%S"))
            elif isinstance(col, date):
                line.append(col.strftime("%Y-%m-%d"))
            else:
                line.append(str(col))

        fp.write("\t".join(line))
        fp.write("\n")
        fp.flush()

    fp.close()
    sys.stdout.write("done! \n")



if __name__ == "__main__":
    usage = "usage: %prog [options]"

    option_list = (
        optparse.make_option(
            "-d", "--database", dest="db", \
            help="specify the db name, default is [%s]" % DB
        ),
        optparse.make_option(
            "-o", "--outfile", dest="out", \
            help="specify the output file name, default is [%s]" % OUT
        ),
        optparse.make_option(
            "-f", "--force", dest="force", action="store_true", \
            help="overwrite output file if exists, default is [N]"
        ),
    )

    option_default = {"db": DB, "out": OUT, "force": False}

    parser = optparse.OptionParser(usage=usage, option_list=option_list)
    parser.set_defaults(**option_default)
    options, args = parser.parse_args()

    run(options, args)
    sys.exit(0)
