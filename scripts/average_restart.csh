#!/bin/tcsh -f
#

set test = 0
set echo verbose

module load nco 
set case1 = cam6
set case2 = cam6_pertlim

set path1 = /glade/scratch/berner/cam6/run
set path2 = /glade/scratch/berner/cam6_pertlim/run
set outpath = /glade/scratch/berner/pseudo_obs_cam6_cam6_pertlim

set list = (cam)

foreach var ( $list )
    #set file2= $path2/${case2}.${var}.r.0001-01-01-03600.nc
    set outfile = ${outpath}/pseudo_obs_$var.r.0001-01-01-21600.nc
    set file1 = ${path1}/${case1}.$var.r.0001-01-01-21600.nc
    set file2 = ${path2}/${case2}.$var.r.0001-01-01-21600.nc
    #
    # Average restart files from file1 and file2 
    #
    #set command = "ncea $file1 $file2 $outfile"
    set command = "ncea -v U,V,T $file1 $file2 $outfile"
    $command
        if ( $status != 0 ) then 
            echo "error executing $command[0-100]..."
            exit -2
        endif
    ls $outfile
    mv $outfile test_pseudo_obs_$var.r.0001-01-01-43200.nc
end #foreach
