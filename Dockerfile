FROM docker-prod.affinitic.be/ploneintranet:latest

USER root
WORKDIR /plone
COPY buildout.cfg /plone/buildout.cfg
COPY src /plone/src
RUN cd /plone \
    && bin/buildout -c buildout.cfg \
    && find /plone \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' + \
    && chown -R plone:plone /plone
RUN apt-get remove -y gcc python-dev \
    && apt-get autoremove -y \
    && apt-get clean

USER plone
VOLUME /plone/var
VOLUME /plone/src
HEALTHCHECK --start-period=1m --timeout=10s --interval=1m CMD curl --fail http://127.0.0.1:8080/ || exit 1
EXPOSE 8080
CMD ["/bin/bash"]
