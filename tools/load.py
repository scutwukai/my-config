#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os
import sys
import optparse
from os.path import expanduser


DB = "test"
BATCH = 10


def placeholder(size, length):
    value = "(%s"
    value += ",%s" * (size - 1)
    value += ")"

    values = []
    for i in xrange(length):
        values.append(value)

    return ",".join(values)


def importdb(conn, table, field, lines):
    sql = "INSERT INTO %s(%s) VALUES %s" % \
        (table, field, placeholder(len(field.split(",")), len(lines)))

    params = []
    for line in lines:
        for column in line.split():
            params.append(column)

    cursor = conn.cursor()
    cursor.execute(sql, params)
    cursor.close()


def run(opts, args):
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

    fp = open(expanduser(args[0]), "rb")

    buf = []
    for line in fp.readlines():
        line = line.strip()

        if len(line) < 1:
            continue

        buf.append(line)
        if len(buf) < opts.batch:
            continue

        importdb(conn, opts.table, opts.field, buf)
        buf = []

    if len(buf) > 0:
        importdb(conn, opts.table, opts.field, buf)

    conn.close()


if __name__ == "__main__":
    usage = "usage: %prog [options] file"

    option_list = (
        optparse.make_option(
            "-b", "--batch", type="int", dest="batch", \
            help="specify the batch size, default is [%s]" % BATCH
        ),
        optparse.make_option(
            "-d", "--database", dest="db", \
            help="specify the db name, default is [%s]" % DB
        ),
        optparse.make_option(
            "-t", "--table", dest="table", \
            help="specify the table name"
        ),
        optparse.make_option(
            "-f", "--field", dest="field", \
            help="specify the field list"
        ),
    )

    option_default = {
        "db": DB,
        "batch": BATCH,
    }

    parser = optparse.OptionParser(usage=usage, option_list=option_list)
    parser.set_defaults(**option_default)
    options, args = parser.parse_args()

    if options.table is None:
        parser.error("table name must be specified.")
        sys.exist(-1)

    if options.field is None:
        parser.error("field(s) name must be specified.")
        sys.exist(-1)

    if len(args) < 1:
        parser.error("data file must be specified.")

    run(options, args)
    sys.exit(0)
