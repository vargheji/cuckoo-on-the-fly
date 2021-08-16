sudo -u postgres psql
	CREATE DATABASE cuckoo;
	CREATE USER cuckoo WITH ENCRYPTED PASSWORD 'password';
	GRANT ALL PRIVILEGES ON DATABASE cuckoo TO cuckoo;