Welcome to the GEO FTP site

************************************************************
Last update: July 16, 2019
************************************************************

Legacy note:
The FTP directories described herein at 
ftp://ftp.ncbi.nlm.nih.gov/geo/ 
replace directories previously available at 
ftp://ftp.ncbi.nlm.nih.gov/pub/geo/

************************************************************
GEO data are available in two main formats:

[1] SOFT
SOFT (Simple Omnibus in Text Format) is a compact, simple, line-based,
ASCII text format that incorporates experimental data and metadata.
See http://www.ncbi.nlm.nih.gov/geo/info/soft2.html#SOFTformat for more information.

[2] MINiML
MINiML (MIAME Notation in Markup Language, pronounced minimal) is an
XML format that incorporates experimental data and metadata. MINiML is
essentially an XML rendering of SOFT format. The MINiML XML schema definition
is available at http://www.ncbi.nlm.nih.gov/geo/info/MINiML.html.

Most files on the FTP site are compressed using gzip (.gz or .tgz extension).
To unzip and read these files in Windows, use a utility such as WinZip or 7-Zip.

For hints on optimizing FTP downloads, please see ftp://ftp.ncbi.nlm.nih.gov/README.ftp.

************************************************************
Site organization
************************************************************

Root directory
ftp://ftp.ncbi.nlm.nih.gov/geo/
has 4 main subdirectories corresponding to the types of GEO records:

datasets/
platforms/
samples/
series/

Each of those has range subdirectories to avoid browser timeouts.
Range subdirectory name is created by replacing the three last digits of the accession
with letters "nnn". For example,
ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/GDS1nnn/
contains record-specific subdirectories for GDS1001, GDS1002, ..., and GDS1995.

Individual record directory in turn has subdirectories named according to the type of
data they contain. Detailed description for each type of record follows.
Note that not all records have the data of all described types.

************************************************************
DataSets
************************************************************

Subdirectory name:
soft/
    GDSxxx.soft.gz
        gzipped SOFT files by DataSet (GDS)
        GEO DataSets (GDS) are curated sets of comparable GEO Sample (GSM) data.
        GDS data tables contain VALUE measurements extracted from original Sample
        records.
    GDSxxx_full.soft.gz
        gzipped full SOFT files by DataSet (GDS)
        Additionally contains up-to-date gene annotation for the DataSet Platform.

Example:
ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/GDS1nnn/GDS1001/

************************************************************
Series
************************************************************

Subdirectory name:
matrix/
    GSExxx_series_matrix.txt.gz or GSExxx-GPLxxx_series_matrix.txt.gz
        gzipped Series-matrix files
        Series_matrix files are summary text files that include a tab-delimited value-matrix table
        generated from the 'VALUE' column of each Sample record, headed by Sample and Series metadata.
        These files include SOFT attribute labels.
        Data generated from multiple Platforms are contained in separate files.
        It is recommended to view Series_matrix files in a spreadsheet application like Excel.
        CAUTION: value data are extracted directly from the original records with no consideration as
        to whether the values are directly comparable.
miniml/
    GSExxx_family.xml.tgz
        tarred gzipped MINiML files by Series (GSE)
        GSExxx_family files contain MINiML-formatted data for all Platforms (GPL)
        and Samples (GSM) associated with one Series (GSE).
soft/
    GSExxx_family.soft.gz
        gzipped SOFT files by Series (GSE)
        GSExxx_family files contain SOFT-formatted data for all Platforms (GPL)
        and Samples (GSM) associated with one Series (GSE).
suppl/
    GSExxx_RAW.tar
        tarred files for all Sample supplementary files corresponding to a Series,
        as well as any additional files the submitter wants make available.

        All submitters have been asked to provide supplementary data (for example, Affymetrix
        .CEL files or cDNA array .GPR files) to accompany their GEO records.  If you are unable
        to locate supplementary data for your experiment of interest, we suggest that you contact
        the submitter directly to encourage that they supply raw data files to GEO so that we may
        make them available to the scientific community.

        If you are interested in locating all instances of a particular file type, we
        suggest that you use Entrez GEO DataSets at
        http://www.ncbi.nlm.nih.gov/gds/.  For example, to locate all .cel files
        corresponding to Affymetrix HG-U133A array that has GEO accession GPL96, search with:
        GPL96 AND "cel"[Supplementary Files]

Example:
ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE15nnn/GSE15701/

************************************************************
Platforms
************************************************************

Subdirectory name:
annot/
    GPLxxx.annot.gz
        gzipped annotation files for Platforms that participate in DataSets (GDS).
        Stable sequence identification information is extracted from original Platform
        records, and queried against current Entrez Gene and UniGene databases at
        periodic intervals to generate up-to-date annotation.

miniml/
    GPLxxx_family.xml.tgz
        tarred gzipped MINiML files by Platform (GPL)
        GPLxxx_family files contain MINiML-formatted data for all Samples (GSM)
        processed using one Platform (GPL), and all Series (GSE) associated
        with those Samples.

soft/
    GPLxxx_family.soft.gz
        gzipped SOFT files by Platform (GPL)
        GPLxxx_family files contain SOFT-formatted data for all Samples (GSM)
        processed using one Platform (GPL), and all Series (GSE) associated
        with those Samples.
suppl/
    GPLxxx.xxx.gz
        gzipped supplementary files for a Platform (GPL)
        A Platform supplementary file most commonly includes a complete, non-condensed
        definition of an array.
        These files are optionally provided by submitters, that is, not all Platforms
        will have supplementary files.
        Typical examples of Platform supplementary file types include .GAL, .XLS or .TXT.

Example:
ftp://ftp.ncbi.nlm.nih.gov/geo/platforms/GPLnnn/GPL891/


NOTE: GPLxxx_family and GSExxx_family SOFT and MINiML files generally contain the same data,
just organized differently.  Both file types are made available so that users may choose which
format best suits their needs.

************************************************************
Samples
************************************************************

Subdirectory name:
suppl/
    GSMxxxxxx.xxx.gz
        gzipped supplementary files for a Sample (GSM)
        A Sample supplementary file most commonly includes raw, non-transformed
        hybridization data, and/or original image files.
        These files are optionally provided by submitters, that is, not all Samples
        will have supplementary files.
        Typical examples of Sample supplementary file types include .GPR, .CEL or .TIFF.

Example:
ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM873nnn/GSM873566/

