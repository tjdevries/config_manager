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
parser.add_argument('--slides_per_page', dest='slides_per_page', default=1,
        help='How many slides are on each pdf page')
praser.add_argument('--horizontal_slides', dest='horizon')
args = parser.parse_args()

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

# Open the file of the pdf that we want.
#   Then we print all the pages into separate jpgs.
# TODO: Add resizing options here.

image_names = []
for current_page in range(num_pages):
    with Image(filename='{0}[{1}]'.format(full_input, current_page)) as img:
        # Save the image as a good nam
        f_name = '{0}-{1}.jpg'.format(full_output_jpeg, current_page)
        img.save(filename=f_name)

        # Append the name to the list of names
        image_names.append(f_name)

# Now we have all of the images that we want
#   So we want to insert them into a pretty markdown document

# Make the markdown document
md_file = open(args.output_md_folder + args.name_md, 'w+')

for jpeg_num, jpeg_name in enumerate(image_names):
    md_file.write('![Slide {0}]({1})\n\n'.format(jpeg_num, jpeg_name))

