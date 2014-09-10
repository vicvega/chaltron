cat > /tmp/slapd.debconf << EOF
slapd slapd/password1 string password.1
slapd slapd/password2 string password.1
slapd slapd/domain string azkaban.co.uk
slapd shared/organization string Azkaban
EOF

/usr/bin/debconf-set-selections /tmp/slapd.debconf

apt-get update -qq
apt-get install slapd ldap-utils -y

cat > /etc/ldap/ldap.conf << EOF
BASE dc=azkaban,dc=co,dc=uk
BINDDN cn=admin,dc=azkaban,dc=co,dc=uk
URI ldap://localhost
EOF

ldapadd -x -w password.1 -f ./ci/ldap/entry.ldif -D 'cn=admin,dc=azkaban,dc=co,dc=uk'
