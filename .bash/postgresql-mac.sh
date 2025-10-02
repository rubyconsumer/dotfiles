echo "  * postgresql-mac: loading"

# Set up PGHOST to be localhost
export PGHOST=localhost

# Add postgres.app to path
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH  # iMac

# Add PostgreSQL 12 for 10x Application
export PATH="/Library/PostgreSQL/12/bin/:$PATH"