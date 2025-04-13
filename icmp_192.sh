#!/bin/bash

# Configura tu segmento
SEGMENTO="192.168.1"
INVENTARIO="inventario_icmp_192.ini"
RESULTADO="icmp_resultado_192.txt"

# Limpia inventario anterior
echo "[icmp_targets]" > $INVENTARIO

# Genera IPs y las agrega al inventario
for i in $(seq 1 254); do
    echo "$SEGMENTO.$i ansible_connection=local" >> $INVENTARIO
done

# Crea un playbook temporal
cat <<EOF > icmp_ping.yml
- name: ICMP Ping scan
  hosts: icmp_targets
  gather_facts: no
  tasks:
    - name: Ejecutar ping ICMP
      shell: ping -c 1 -W 1 {{ inventory_hostname }}
      register: ping_output
      ignore_errors: yes

    - name: Guardar salida si responde
      local_action:
        module: lineinfile
        path: $RESULTADO
        create: yes
        line: "{{ inventory_hostname }} responde"
      when: ping_output.rc == 0
EOF

# Ejecuta el playbook
ansible-playbook -i $INVENTARIO icmp_ping.yml

# Muestra resultado
echo "Hosts que respondieron al ping:"
cat $RESULTADO
