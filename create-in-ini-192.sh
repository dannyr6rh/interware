for ip in $(seq 1 254); do
  echo "192.168.1.$ip" >> inventario_tmp_192.txt
done

echo "[segmento]" | cat - inventario_tmp_192.txt > inventario_final192.ini

ansible -i inventario_final192.ini segmento -m ping > resultado_192.txt
