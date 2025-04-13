for ip in $(seq 1 254); do
  echo "180.160.1.$ip" >> inventario_tmp.txt
done

echo "[segmento]" | cat - inventario_tmp.txt > inventario_final180.ini

ansible -i inventario_fina180l.ini segmento -m ping > resultado.txt
