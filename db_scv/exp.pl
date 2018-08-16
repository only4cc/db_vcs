#
#   JTS 03-Mayo-2018
# 

use Time::Out qw(timeout) ;

my $SERVERNAME= shift;
my $USERNAME  = shift;
my $PASS      = shift;
my $ORG       = shift;

# Constantes
my $SECS      = 30;  # Dado que no tiene timeout el mssql-scripter
my $DIREXP="C:\\e-contact\\admin\\mssql-scripter\\exp2";

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =localtime(time);
$mon  = '0'.$mon  if ( $mon < 10 );
$mday = '0'.$mday if ( $mday < 10 );
$hour = '0'.$hour if ( $hour < 10 );
$min  = '0'.$min  if ( $min < 10 );
my $TS=($year+1900).'-'.($mon+1).'-'.$mday;
my $time=$hour.':'.$min;

print "creando directorio local $DIREXP\\local\\$ORG\\$SERVERNAME ";
system("mkdir $DIREXP\\local\\$ORG\\$SERVERNAME");
print "creando directorio para git $DIREXP\\dba-structure\\$ORG\\$SERVERNAME";
system("mkdir $DIREXP\\dba-structure\\$ORG\\$SERVERNAME");

# Obtiene nombres de las BBDD ...
my @dbnames;
my $dbnamefile = 'C:\\e-contact\\admin\\mssql-scripter\\db_scv\\dbnames.txt';
open( my $fh, "$dbnamefile" ) or die "Error: no se pudo leer el archivo $dbnamefile $!\n";
while ( my $db = <$fh> ) {
    chomp($db);
	push @dbnames, $db; 
	# print "DB $db\n";
}
close($fh);

print "Procesando las bbdd de $SERVERNAME ...\n";
foreach my $db ( @dbnames ) {

    print "Procesando $db ...\n";
    # Script name para Git
    my $FNAME="${db}_${TS}.sql";
    my $F2GIT="$DIREXP\\local\\$ORG\\$SERVERNAME\\$db.sql";  # uso temporal

	my $output = "$DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME";

	timeout $SECS => sub {
		print "Generando $output  ...\n";
		`call C:\\e-contact\\admin\\mssql-scripter\\mssql-scripter --server $SERVERNAME --user $USERNAME --password $PASS -d $db --continue-on-error --logins --object-permissions --display-progress  -f $output`;
#		`call C:\\e-contact\\admin\\mssql-scripter\\mssql-scripter --server $SERVERNAME --user $USERNAME --password $PASS -d $db --continue-on-error --logins --display-progress  -f $output`;
	};
	
	if ($@) {
		print "\n\nTimeout generando para $SERVERNAME $db ... \n\n";
		exit;
    }
    print "eliminando comentarios con fecha ...\n";
	`echo  " " > $output.sincom`;
    system("perl C:\\e-contact\\admin\\mssql-scripter\\db_scv\\clean.pl $output > $output.sincom ");

    print "moviendo para control de versiones ...\n";
    print "desde  $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME\.sincom\n";
    print "hasta  $F2GIT\n";

	print  "copy $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME\.sincom   $F2GIT\n";
    system("copy $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME\.sincom   $F2GIT");
	
	#print   "del     $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME\.sincom\n";
    system( "del     $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME\.sincom");
	system( "del     $DIREXP\\local\\$ORG\\$SERVERNAME\\$FNAME");

	#print "Siguiente ... \n";		
	#my $a=<STDIN>;

    # volviendo a directorio del batch ...
    # chdir ("C:\\e-contact\\admin\\mssql-scripter\\db_scv");
}



