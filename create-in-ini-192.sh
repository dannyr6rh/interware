for ip in $(seq 1 254); do
  echo "192.168.1.$ip" >> inventario_tmp.txt
done

echo "[segmento]" | cat - inventario_tmp.txt > inventario_final192.ini

ansible -i inventario_final192.ini segmento -m ping > resultado.txt
