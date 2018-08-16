#
use strict; 
use warnings;
use File::stat;

my $dirname = 'C:\\e-contact\\admin\\mssql-scripter\\exp\\local\\LAB-CG4' || shift;

my @files = glob("$dirname\\*.*");

for my $file (
	sort {
        my $a_stat = stat($a);
        my $b_stat = stat($b);
        $a_stat->mtime <=> $b_stat->mtime;
		}  @files ) {
    print  "$file\n";
}

