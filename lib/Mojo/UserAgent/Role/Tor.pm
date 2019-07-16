
package Mojo::UserAgent::Role::Tor;
use Mojo::Base '-role';
use IO::Socket::INET;

our $VERSION = "1.00";



sub connect_to_tor {

 my ($self,$tor_port, $tor_control_port,$password) = @_;

#peer port 9151
$self->{tor_socket} = IO::Socket::INET->new(
        PeerAddr => '127.0.0.1',
        PeerPort => $tor_control_port) or  die 'Could not connect to tor';



    my $answer = q{};

    $self-> {tor_socket}->send('AUTHENTICATE '.'"'.$password.'"'."\n");
    $self-> {tor_socket}->recv($answer, 1024);
    $answer eq "250 OK\r\n" or die 'Authentication Failure';


$self->proxy
->http("socks://localhost:$tor_port")
->https("socks://localhost:$tor_port");





}

sub rotate_ip {
 
    my ($self) =@_;
	
  
	
	 my $answer = q{};
 
    $self->{tor_socket}->send("SIGNAL NEWNYM\n");
    $self->{tor_socket}->recv($answer, 1024);
	print $answer;
    return 0 unless $answer eq "250 OK\r\n";

  
    return 1;


}

1;




__END__

=encoding utf-8

=head1 NAME

Mojo::UserAgent::Role::Tor - A role to use Mojo::UserAgent over Tor.

=head1 SYNOPSIS
	use Mojo::UserAgent;

	my $ua = Mojo::UserAgent->new->with_roles('+Tor');
	$ua->connect_to_tor(9150,9151,'password');
	print $ua->get('https://api.ipify.org/?format=json' )->res->json->{ip},"\n";
	$ua->rotate_ip();
	print $ua->get('http://httpbin.org/ip')->res->json->{origin},"\n";
	
=head1 Methods

L<Mojo::UserAgent::Role::Tor> has the following Methods:

=head2 connect_to_tor($tor_port, $tor_control_port,$password); 

    $ua->connect_to_tor(9150,9151,'password');
	
try to connect to tor proxy and control port 

=head2 rotate_ip

  $ua->rotate_ip;

Try to get another exit node via tor.
Returns 1 for success and 0 for failure.

=head1 AUTHOR

b03cmans <b03@cmans.com>
