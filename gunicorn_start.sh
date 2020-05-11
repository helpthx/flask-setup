#!/bin/bash

# As seen in http://tutos.readthedocs.org/en/latest/source/ndg.html

APP_DIR="/flask_setup"
NUM_CPU=`nproc --all`

# Seta um novo diretório foi passado como raiz para o APP
# caso esse tenha sido passado como parâmetro
if [ "$1" ]
then
    APP_DIR="$1"
fi

NAME="ABIN API"                                             # Name of the application (*)
FASKDIR=flask_setup/                    # Django project directory (*)
SOCKFILE=flask_setup/run/gunicorn.sock    # we will communicate using this unix socket (*)
USER=`whoami`                                   # the user to run as (*)
GROUP=`whoami`                                  # the group to run as (*)
NUM_WORKERS=4             # how many worker processes should Gunicorn spawn (*)

echo "Starting $NAME as `whoami` on base dir $APP_DIR"

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec gunicorn --workers=6 --threads=2  wsgi:app -b 0.0.0.0:8001 --bind=unix:$SOCKFILE \
  --error-logfile /flask_setup/logs/gunicorn/error \
  --access-logfile /flask_setup/logs/gunicorn/access