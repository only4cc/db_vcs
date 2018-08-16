# EjemplO:
# Script Date: 5/7/2018 7:21:17 PM ******/
#
my $fname=shift;
my $l;
open( my $fh, $fname) or die "$!\n";
while ( my $l=<$fh> ) {
	if ( $l =~ /Script Date: / ) {
		$l =~ s/Script Date: (.*) //;
	}
	if ( $l =~ /WITH PASSWORD=N'/ ) {
		$l =~ s/WITH PASSWORD=N'(.*)'/WITH PASSWORD=N'(na)'/;
	}
	print $l;
}
close $fh;
