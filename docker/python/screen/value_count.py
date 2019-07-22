import csv
from glob import glob

def _gen_files(source_dir='/root/data/'):
    for filepath in glob(source_dir + '**/*.csv'):
        yield filepath

print('generate value counts')
