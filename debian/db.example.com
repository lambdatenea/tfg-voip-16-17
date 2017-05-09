; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     ns.example.com. root.example.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.example.com.
ns      IN      A       192.168.1.131

;also list other computers
www     IN      A       10.2.0.4
ssh     IN      A       10.2.0.4
sip     IN      A       10.2.0.4

_sip._udp.example.com.  300     IN      SRV     0       0       5060    sip.example.com.
