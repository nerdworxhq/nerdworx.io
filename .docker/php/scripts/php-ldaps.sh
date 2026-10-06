chmod 600 /etc/openldap/certs/*

echo "TLS_REQCERT   never" >> /etc/openldap/ldap.conf
echo "TLS_CACERTDIR /etc/openldap/certs" >> /etc/openldap/ldap.conf
