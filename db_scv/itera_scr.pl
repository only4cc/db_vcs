#
# Paramateros
#

my $DIREXP     = shift;
my $ORG        = shift;
my $FNAME      = shift;

my $servername = shift;
my $username   = shift;
my $pass       = shift;

my $output = "$DIREXP\\local\\$ORG\\$servername\\$FNAME";

# print $output;

my $dbnamefile = 'C:\\e-contact\\admin\\mssql-scripter\\db_scv\\dbnames.txt';
open( my $fh, "$dbnamefile" ) or die "Error: no se pudo leer el archivo $dbnamefile $!\n";

while ( my $db = <$fh> ) {
  chomp($db);
  `call C:\\e-contact\\admin\\mssql-scripter\\mssql-scripter --server $servername --user $username --password $pass -d $db --continue-on-error --logins --object-permissions --display-progress  -f $output.$db`;

}
close($fh);

