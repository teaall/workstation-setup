# Molecule managed

{% if item.registry is defined %}
FROM {{ item.registry.url }}/{{ item.image }}
{% else %}
FROM {{ item.image }}
{% endif %}

ENV ANSIBLE_USER=test-user DEPLOY_GROUP=test-group
ENV SUDO_GROUP={{'sudo' if 'debian' in item.image else 'wheel' }}
RUN set -xe \
    && groupadd -r ${ANSIBLE_USER} \
    && groupadd -r ${DEPLOY_GROUP} \
    && useradd -m -g ${ANSIBLE_USER} ${ANSIBLE_USER} \
    && usermod -aG ${SUDO_GROUP} ${ANSIBLE_USER} \
    && usermod -aG ${DEPLOY_GROUP} ${ANSIBLE_USER} \
    && sed -i "/^%${SUDO_GROUP}/s/ALL\$/NOPASSWD:ALL/g" /etc/sudoers