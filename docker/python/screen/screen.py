import csv
import sys
from glob import glob

def _gen_files(source_dir='/root/data/'):
    depth = 5
    dir_splat = ''
    for d in range(0,depth):
        dir_splat += '*/'
        for filepath in glob(source_dir + '/' + dir_splat + '*.csv'):
            yield filepath

def _print_exception():
    print(sys.exc_info())

def avg():
    file_count = 0
    field_count = 0

    try:
        for file in _gen_files():
            file_count += 1

            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    field_count += len(row)
                    break
        print(str(field_count/file_count))
    except(Exception):
        _print_exception()

def total():
    lines = 0
    try:
        for file in _gen_files():
            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    lines += 1
        print(lines)
    except(Exception):
        _print_exception()

def value_counts():
    try:
        value_counts = {}
        for file in _gen_files():
            with open(file, encoding='ISO-8859-1') as f:
                csv_reader = csv.reader(f, dialect='excel')

                for row in csv_reader:
                    for value in row:
                        if value in value_counts:
                            value_counts[value] += 1
                        else:
                            value_counts[value] = 1
        
        with value_counts_csv = open('/root/src/value_counts.csv', 'w'):
            csv_writer = csv.writer(value_counts_csv)
        

    except(Exception):
        _print_exception()


avg()
total()
