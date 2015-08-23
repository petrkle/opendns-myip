package OpenDNS::MyIP;
# ABSTRACT: Get your public IP address

use 5.006;
use strict;
use warnings;

use Net::DNS;
use Carp;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;
require AutoLoader;

our @ISA = qw(Exporter AutoLoader);
our @EXPORT = qw(get_ip);

=head1 SYNOPSIS

	use OpenDNS::MyIP qw(get_ip);
	
	my $ip = get_ip(); # 12.34.56.78

=method get_ip()

Return public IP address
=cut
sub get_ip{
	my $resolver = new Net::DNS::Resolver(
			nameservers => [ '208.67.220.220', '208.67.222.222' ],
			recurse     => 0,
			debug       => 0
			);

	my $query = $resolver->query( 'myip.opendns.com' );

	if ($query) {
		foreach my $rr ($query->answer) {
			next unless $rr->type eq "A";
			return $rr->rdatastr;
		}
	} else {
		confess($resolver->errorstring);
	}
}

1;
__END__

=head1 SEE ALSO

L<https://metacpan.org/pod/WWW::IP>

L<https://metacpan.org/pod/WWW::curlmyip>

L<https://metacpan.org/pod/WWW::ipinfo>

L<https://metacpan.org/pod/WWW::hmaip>

L<https://metacpan.org/pod/WWW::PerlTricksIP>

=cut
1;
