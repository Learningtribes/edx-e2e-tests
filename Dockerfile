# To build this Dockerfile:
#
# From the root of the edx-e2e-tests repository:
#
# docker build . -t ltdps/e2e:hawthorn.lt

FROM edxops/python:2.7
MAINTAINER ltdps

# Install system libraries needed for lxml
RUN apt-get update -qqy \
    && apt-get -qqy install \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ADD . /edx-e2e-tests
WORKDIR /edx-e2e-tests

# Install requirements and pages
# Deletes the edx-platform checkout afterwards, it will be mapped in from the host
RUN pip install -r requirements/base.txt \
    && paver install_pages \
    && rm -rf /edx-e2e-tests/lib

# Just wait for the user to launch a shell when started via docker-compose
CMD ["sleep", "infinity"]
