die "perl $0 <idlist> <fa> <OUT>" unless ( @ARGV == 3 );
use Math::BigFloat;
use Bio::SeqIO;
use Bio::Seq;

#���뵰������
$in = Bio::SeqIO->new(
      -file   => "$ARGV[1]",
	  -format => 'Fasta'
);
#����������У�
$out = Bio::SeqIO->new(
      -file   => ">$ARGV[2]",
	  -format => 'Fasta'
);
#��ȡ��Ҫ��ȡ����ID
my  %keep = ();
open IN, "$ARGV[0]" or die "$!";

while (<IN>) {
	chomp;
	next if /^#/;
	my @a = split /\s+/;
	$keep{$a[0]}=1;
}
close(IN);

#�����Ҫ�Ļ��������
while ( my $seq = $in->next_seq() ) {
	my ( $id, $sequence, $desc ) = ( $seq->id, $seq->seq, $seq->desc );
	
	if (exists $keep{$id} ) {
		$out->write_seq($seq);
	}
}
$in->close();
$out-> close();