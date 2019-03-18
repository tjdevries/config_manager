#!/bin/bash

base_folder="/home/tj_chromebook/Git/config_manager/python/school_tools/"
output_folder="/home/tj_chromebook/test/"

#./pdf_to_markdown_slides.py \
#    --input_folder $base_folder \
#    --input_file 1col1row_test.pdf \
#    --output_jpeg_folder  $output_folder/slides \
#    --output_md_folder $output_folder \
#    --name_md 1_col_1_row_test.md

./pdf_to_markdown_slides.py \
    --input_folder $base_folder  \
    --input_file 2col3row_test.pdf \
    --output_jpeg_folder $output_folder/slides \
    --output_md_folder $output_folder \
    --name_md 2_col_3_row_test.md \
    --columns 2 \
    --rows 3 \
    -v

