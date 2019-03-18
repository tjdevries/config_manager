#!/usr/bin/env python3

# Standard Modules
import argparse
import os

# Third Party Modules
from PyPDF2 import PdfFileWriter, PdfFileReader
from wand.image import Image

# Example usage of Image
# with Image(filename="/home/tj_chromebook/this.pdf[0]") as img:
#     img.save(filename="/home/tj_chromebook/temp.jpg")

# Arg parsing
parser = argparse.ArgumentParser(description='A pdf splitter that then automagically inserts references into a markdown document')
# I split these up because I will probably almost always have my pdfs be in my downloads folder
#   However, that may not be true of another user. Compromise :)
parser.add_argument('--input_folder', dest='input_folder', default='~/Downloads/',
        help='The folder where one can find the pdf to split')
parser.add_argument('--input_file', dest='input_file', 
        help='The input pdf file you would like to split')
parser.add_argument('--output_jpeg_folder', dest='output_jpeg_folder', default=None,
        help='Where the jpegs of the split pages will be stored')
parser.add_argument('--output_md_folder', dest='output_md_folder', default=None,
        help='Where the markdown document will be stored')
parser.add_argument('--name_md', dest='name_md',
        help='The name of the markdown document')
parser.add_argument('--columns', dest='columns', default=1,
        help='How many columns you want to split each page into')
parser.add_argument('--rows', dest='rows', default=1,
        help='How many rows you want to split each page into')
parser.add_argument('-v', dest='verbose', default=False, action='store_true',
        help='Enable verbose output')
args = parser.parse_args()

verbose = args.verbose

# TODO: Replace '~' with '/home/username/'
# folders = [args.input_folder, args.output_jpeg_folder, args.output_md_folder]

# TODO: Add checks to make sure all the inputs are valid

# Set some shorter names
full_input = args.input_folder + args.input_file

#   Get the jpeg name (or the input file without the pdf)
if '.pdf' == args.input_file[-4:]:
    jpeg_name = args.input_file[:-4]
else:
    jpeg_name = args.input_file

full_output_jpeg = args.output_jpeg_folder + jpeg_name

# Get the total number of pages in the pdf document
#   Not sure what `rb` stands for
input_pdf = PdfFileReader(open(full_input, "rb"))
num_pages = input_pdf.getNumPages()

if verbose:
    print('Input PDF is `{0}` \n\tand is {1} pages long'.format(input_pdf, num_pages)) 

# Open the file of the pdf that we want.
#   Then we print all the pages into separate jpgs.
# TODO: Add resizing options here.

# Rename the columns and rows to shorter names
try:
    columns = int(args.columns)
except TypeError:
    print('Please input an integer number for columns.')
    exit(1)

try:
    rows = int(args.rows)
except TypeError:
    print('Please input an integer number for rows.')

# Set the number of slides to zero. This will be incremented up
slide_number = 0
image_names = []

# Get each individual page of the document using {filename}[page_number] format of the imagemagick package
for current_page in range(num_pages):
    # Open the document and interact with it as `img`.
    with Image(filename='{0}[{1}]'.format(full_input, current_page)) as img:
        # Get the image size to know where we need to split it
        width = img.size[0]
        height = img.size[1]

        if verbose:
            print('Width: {0}\nHeight: {1}'.format(width, height))

        # Split the image into the correct number of columns and rows
        #
        #   First cycle through the rows and the columns
        for row in range(rows):
            for column in range(columns):
                # Image pixels of img[left:right, top:bottom]
                left = int(column * width/columns)
                right = int((column + 1) * width/columns)
                top = int(row * height/rows)
                bottom = int((row + 1) * height/rows)
                with img[left:right, top:bottom] as cropped:
                    if verbose:
                        print('\tCropped image pixels are {0}:{1}, {2}:{3}'.format(left, right, top, bottom))
                        print('\tCropped image size is: {0}'.format(cropped.size))
        
        # Save the image as a unique name. 
        # It will be 
        f_name = '{0}-{1}.jpg'.format(full_output_jpeg, current_page)
        img.save(filename=f_name)

        # Append the name to the list of names, and increment the counter
        image_names.append(f_name)
        slide_number += 1

# Now we have all of the images that we want
#   So we want to insert them into a pretty markdown document

# Make the markdown document
md_file = open(args.output_md_folder + args.name_md, 'w+')

for jpeg_num, jpeg_name in enumerate(image_names):
    md_file.write('![Slide {0}]({1})\n\n'.format(jpeg_num, jpeg_name))

