import csv
import sys
from glob import glob

def __gen_files(source_dir='/root/data/'):
    depth = 5
    dir_splat = ''
    for d in range(0,depth):
        dir_splat += '*/'
        for filepath in glob(source_dir + '/' + dir_splat + '*.csv'):
            yield filepath

def __print_exception():
    print(sys.exc_info())

def avg():
    file_count = 0
    field_count = 0

    try:
        for file in __gen_files():
            file_count += 1

            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    field_count += len(row)
                    break
        print(str(field_count/file_count))
    except(Exception):
        __print_exception()

def total():
    lines = 0
    try:
        for file in __gen_files():
            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    lines += 1
        print(lines)
    except(Exception):
        __print_exception()

def value_counts():
    try:
        value_counts = {}
        for file in __gen_files():
            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    for value in row:
                        if value in value_counts:
                            value_counts[value] += 1
                        else:
                            value_counts[value] = 1

        with open('/root/src/value_counts.csv', 'w', encoding='utf-8') as value_counts_csv:
            csv_writer = csv.writer(value_counts_csv, quoting=csv.QUOTE_MINIMAL)
            csv_writer.writerow(['value', 'count'])
            for value in value_counts:
                csv_writer.writerow(['"{value}"'.format(value=value), value_counts[value]])
                #csv_writer.writerow(['"{value}"'.format(value=value.replace('"', '\"')), value_counts[value]])
    except(Exception):
        __print_exception()


avg()
total()
value_counts()
