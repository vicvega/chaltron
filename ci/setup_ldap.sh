cat > /tmp/slapd.debconf << EOF
slapd slapd/password1 string Secret007!
slapd slapd/password2 string Secret007!
EOF

/usr/bin/debconf-set-selections /tmp/slapd.debconf

apt-get update -qq
apt-get install slapd ldap-utils -y

cat > /etc/ldap/ldap.conf << EOF
BASE dc=azkaban,dc=co,dc=uk
BINDDN cn=admin,dc=azkaban,dc=co,dc=uk
URI ldap://localhost
EOF

ldapadd -x -w Secret007! -f ./ci/ldap/entry.ldif -D 'cn=admin,dc=azkaban,dc=co,dc=uk'
