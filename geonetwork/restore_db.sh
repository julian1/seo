set -x
psql -d postgres -c 'drop database geonetwork' || exit
pg_restore -C /vagrant/geonetwork/geonetwork.dump -d postgres 



