FROM concourse/concourse:3.8.0

# Install AWS CLI
RUN apt-get update \
    && apt-get -y install python curl unzip \
    && cd /tmp \
    && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm awscli-bundle.zip \
    && rm -rf awscli-bundle

# Install entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Add metadata
ADD VERSION /VERSION
ADD TAG /TAG

# Overwrite entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
