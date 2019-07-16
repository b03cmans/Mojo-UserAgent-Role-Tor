NAME
   
   Mojo::UserAgent::Role::Tor - A role to use Mojo::UserAgent over Tor.

SYNOPSIS
        
    use Mojo::UserAgent;
           
           my $ua = Mojo::UserAgent->new->with_roles('+Tor');
           
           $ua->connect_to_tor(9150,9151,'password');
           
           print $ua->get('https://api.ipify.org/?format=json' )->res->json->{ip},"\n";
           
           $ua->rotate_ip();
           
           print $ua->get('http://httpbin.org/ip')->res->json->{origin},"\n";

Methods
   
   Mojo::UserAgent::Role::Tor has the following Methods:

  
  connect_to_tor($tor_port, $tor_control_port,$password);
        
       
       $ua->connect_to_tor(9150,9151,'password');

  
    Try to connect to tor proxy and control port
  
  rotate_ip
      
      $ua->rotate_ip;

    Try to get another exit node via tor. Returns 1 for success and 0 for
    failure.


